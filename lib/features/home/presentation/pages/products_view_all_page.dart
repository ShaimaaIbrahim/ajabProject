import 'dart:ui';

import 'package:ajb1/core/constants.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ajb1/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ajb1/core/entities/extra_glasses_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:ajb1/features/profile/domin/repositories/profile_repository.dart';
import 'package:ajb1/features/profile/domin/usecases/get_user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';


import '../../../../main.dart';
import 'package:get/get.dart' as Get;

class ProductsVeiwAllPage extends StatefulWidget {
  static const routeName = '/home/pages/ProductsVeiwAllPage';
  final String? appBarTitle;
  final bool? fromHome;

  ProductsVeiwAllPage({this.appBarTitle, this.fromHome});

  @override
  _TestResultPageState createState() => _TestResultPageState();
}

class _TestResultPageState extends State<ProductsVeiwAllPage> {
  //final args = Get.Get.arguments as ProductsViewAllArgs;

  var _cancelToken = CancelToken();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //=========================================================================
    print(widget.appBarTitle);
    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        widget.appBarTitle != null
            ? Translations.of(context).translate('offers')
            : Translations.of(context).translate('products'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: Container(
            height: height,
            child: BuildGridProductWidget(
              cancelToken: _cancelToken,
              itemWidth: globalSize.setWidthPercentage(43, context),
              itemHeight: globalSize.setWidthPercentage(60, context),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: globalSize.setWidthPercentage(43, context) /
                    globalSize.setWidthPercentage(60, context),
              ),
              fromHome: widget.fromHome!,
              isEnablePagination: true,
              isEnableRefresh: true,
              params: {FILTER_BEST_SALES: '0'},
            )));
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
