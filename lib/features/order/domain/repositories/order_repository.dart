import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/repositories/repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/features/order/data/requests/order_request.dart';
import 'package:ajb1/features/order/domain/entities/general_order_item_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


abstract class OrderRepository extends Repository {

  Future<Result<BaseError, List<GeneralOrderItemEntity>>> getOrders({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });
  Future<Result<BaseError, Object>> sendOrder({
    required OrderRequest request,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> deleteOrder({
    required int id,
    CancelToken cancelToken,
  });
}
