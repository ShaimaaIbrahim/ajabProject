import 'package:ajb1/core/errors/connection_error.dart';
import 'package:ajb1/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import 'loading_widget.dart';

class NetworkWidget<T> extends StatefulWidget {
  // The Function() which returns the data.
  final Future<Result<BaseError, T>> Function() fetcher;

  // The Function() which builds the UI.
  final Widget Function(BuildContext context, T data) builder;

  // The Function() which builds the connection error's widget.
  final Widget Function(BuildContext context, VoidCallback? callback)?
      connectionErrorWidgetBuilder;

  // The Function() which builds the unknown error's widget.
  final Widget Function(BuildContext context, VoidCallback? callback)?
      unknownErrorWidgetBuilder;

  // The Function() which builds the loading widget.
  final WidgetBuilder? loadingWidgetBuilder;

  const NetworkWidget({
    Key? key,
    required this.builder,
    required this.fetcher,
    this.connectionErrorWidgetBuilder,
    this.unknownErrorWidgetBuilder,
    this.loadingWidgetBuilder,
  }) : super(key: key);

  @override
  _NetworkWidgetState<T> createState() => _NetworkWidgetState<T>();
}

class _NetworkWidgetState<T> extends State<NetworkWidget<T>> {
  late NetworkBloc<T> _bloc;

  @override
  void initState() {
    super.initState();

    // Init the local bloc and fire fetching data event.
    _bloc = NetworkBloc<T>()..add(NetworkFetchEvent<T>(fetch: widget.fetcher));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc<T>, NetworkState>(
      bloc: _bloc,
      builder: (BuildContext context, NetworkState state) {
        if (state is LoadingState) {
          return widget.loadingWidgetBuilder != null
              ? widget.loadingWidgetBuilder!(context)
              : LoadingWidget();
        } else if (state is DoneState<T>) {
          return widget.builder(context, state.data);
        } else if (state is FailureState) {
          final error = state.error;
          if (error is ConnectionError) {
            return widget.connectionErrorWidgetBuilder != null
                ? widget.connectionErrorWidgetBuilder!(context, state.callback)
                : ConnectionErrorWidget(callback: state.callback);
          } else {
            return widget.unknownErrorWidgetBuilder != null
                ? widget.unknownErrorWidgetBuilder!(context, state.callback)
                : UnexpectedErrorWidget(callback: state.callback);
          }
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }
}

@immutable
abstract class NetworkState extends Equatable {}

class UninitializedState extends NetworkState {
  @override
  String toString() => 'UninitializedState';

  @override
  List<Object> get props => [];
}

class LoadingState extends NetworkState {
  @override
  String toString() => 'LoadingState';

  @override
  List<Object> get props => [];
}

class DoneState<T> extends NetworkState {
  final T data;

  DoneState({required this.data}) : assert(data != null);

  @override
  String toString() => 'DoneState';

  @override
  List<Object> get props => [data!];
}

class FailureState extends NetworkState {
  final BaseError? error;
  final VoidCallback? callback;

  FailureState({required this.error, this.callback});

  @override
  String toString() => 'FailureState';

  @override
  List<Object> get props =>
      [error ?? 'error null', callback ?? 'callback null'];
}

class NetworkFetchEvent<T> {
  final Future<Result<BaseError, T>> Function() fetch;

  NetworkFetchEvent({required this.fetch});

  @override
  String toString() => 'NetWorkFetchEvent<${T.toString()}>';
}

class NetworkBloc<T> extends Bloc<NetworkFetchEvent<T>, NetworkState> {
  var tempResult;

  NetworkBloc() : super(UninitializedState());

  @override
  Stream<NetworkState> mapEventToState(NetworkFetchEvent<T> event) async* {
    yield LoadingState();
    final result = await event.fetch();
    // Check for errors..
    if (result.hasErrorOnly) {
      final error = result.error;
      yield FailureState(
        error: error,
        callback: () {
          this.add(event);
        },
      );
    }
    // Check for data existing..
    else
      yield DoneState<T>(data: result.data!);
  }
}
