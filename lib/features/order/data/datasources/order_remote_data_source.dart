import 'package:ajb1/core/datasources/remote_data_source.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/features/order/data/models/general_order_item_model.dart';
import 'package:ajb1/features/order/data/requests/order_request.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class OrderRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<GeneralOrderItemModel>>> fetchOrders({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> sendOrder({
    OrderRequest orderRequest,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> deleteOrder({
    required int id,
    CancelToken cancelToken,
  });
}
