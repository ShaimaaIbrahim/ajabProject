import 'package:ajb1/core/entities/base_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:flutter/material.dart';
import 'package:ajb1/core/entities/notifications_entity.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ajb1/core/ui/widget/network/network_list.dart';
import 'package:ajb1/core/usecases/get_notifications.dart';
import 'package:ajb1/features/notification/presentation/widgets/item_notification_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/items_shimmer/item_general_shimmer.dart';
import 'package:ajb1/core/ui/widget/network/network_grid.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:ajb1/features/product/domin/usecases/get_products.dart';
import 'package:ajb1/features/product/presentation/widgets/item_product_home_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/features/user_management/presentation/pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as Get;
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/icon_size.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'network_widget.dart';

class NetworkGrid<T extends BaseEntity> extends StatelessWidget {
  final bool enableRefresh;
  final bool enablePagination;
  final int pageSize;
  final bool isScroll;
  final int crossCount;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Future<Result<BaseError, List<T>>> Function(int pageSize, int pageIndex)
      loader;
  final WidgetBuilder placeHolder;
  final WidgetBuilder loadingWidgetBuilder;
  final SliverGridDelegate sliverGridDelegate;

  NetworkGrid(
      {Key? key,
      required this.loader,
      required this.itemBuilder,
      this.enableRefresh = false,
      this.enablePagination = false,
      this.pageSize = 10,
      this.isScroll = true,
      required this.placeHolder,
      required this.loadingWidgetBuilder,
      this.crossCount = 3,
      required this.sliverGridDelegate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetworkWidget<List<T>>(
      builder: (context, networkItems) {
        if (networkItems.isEmpty) {
          return placeHolder(context);
        }
        return _NetworkGridContent<T>(
          items: networkItems,
          enableRefresh: enableRefresh,
          enablePagination: enablePagination,
          pageSize: pageSize,
          crossCount: crossCount,
          itemBuilder: itemBuilder,
          loader: loader,
          sliverGridDelegate: sliverGridDelegate,
          isScroll: isScroll,
        );
      },
      fetcher: () {
        return loader(pageSize, 0);
      },
      loadingWidgetBuilder: loadingWidgetBuilder,
    );
  }
}

class _NetworkGridContent<T extends BaseEntity> extends StatefulWidget {
  final List<T> items;
  final bool enableRefresh;
  final bool enablePagination;
  final bool isScroll;
  final int pageSize;
  final int crossCount;
  final dynamic itemBuilder;
  final Future<Result<BaseError, List<T>>> Function(int pageSize, int pageIndex)
      loader;
  final SliverGridDelegate sliverGridDelegate;

  const _NetworkGridContent({
    Key? key,
    required this.items,
    required this.enableRefresh,
    required this.enablePagination,
    required this.pageSize,
    required this.crossCount,
    required this.itemBuilder,
    required this.loader,
    required this.sliverGridDelegate,
    required this.isScroll,
  }) : super(key: key);

  @override
  __NetworkGridContentState<T> createState() => __NetworkGridContentState<T>();
}

class __NetworkGridContentState<T extends BaseEntity>
    extends State<_NetworkGridContent> {
  // Smart Refresher Controller.
  final _controller = RefreshController();

  // Pagination State.
  List<BaseEntity> _items = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // _items = [...widget.items];
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: widget.enableRefresh,
      enablePullUp: widget.enablePagination,
      header: MaterialClassicHeader(
        color: Theme.of(context).accentColor,
      ),
      footer: ClassicFooter(
        loadingIcon: CircularProgressIndicator(),
        canLoadingText: Translations.of(context).translate('canLoadingText'),
        failedText: Translations.of(context).translate('loadFailedText'),
        idleText: Translations.of(context).translate('idleRefreshText'),
        loadingText: Translations.of(context).translate('loadingText'),
        noDataText: '',
        textStyle:
            textStyle.smallTSBasic.copyWith(color: globalColor.accentColor),
      ),
      controller: _controller,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: GridView.builder(
        gridDelegate: widget.sliverGridDelegate,
        itemBuilder: (context, index) =>
            widget.itemBuilder(context, _items[index]),
        itemCount: _items.length,
        shrinkWrap: true,
        padding: const EdgeInsets.only(
            left: EdgeMargin.subSubMin, right: EdgeMargin.subSubMin),
        physics: widget.isScroll
            ? BouncingScrollPhysics()
            : NeverScrollableScrollPhysics(),
      ),
    );
  }

  void _onRefresh() async {
    final result = await widget.loader(widget.pageSize, 0);
    if (result.hasDataOnly) {
      _currentPage = 0;
      setState(() {
        _items.clear();
        result.data?.forEach((entry) => _items.add(entry));
      });
    }
    _controller.refreshCompleted(resetFooterState: true);
  }

  void _onLoading() async {
    final result = await widget.loader(widget.pageSize, _currentPage + 1);
    if (result.hasDataOnly) {
      if (result.data?.isNotEmpty ?? false) {
        _currentPage++;
        setState(() {
          result.data?.forEach((entry) => _items.add(entry ));
        });
        _controller.loadComplete();
      } else
        _controller.loadNoData();
    } else if (result.hasErrorOnly || result.hasDataAndError) {
      _controller.loadFailed();
    }
  }
}
