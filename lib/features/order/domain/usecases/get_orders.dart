import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/order/domain/entities/general_order_item_entity.dart';
import 'package:ajb1/features/order/domain/repositories/order_repository.dart';
import 'package:dio/dio.dart';

import 'delete_order.dart';

class GetOrdersParams extends BaseParams {
  final Map<String, String>? filterParams;
  final int? pagesize;
  final int? page;

  GetOrdersParams({
    this.filterParams,
    this.pagesize,
    this.page,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetOrders extends UseCase<List<GeneralOrderItemEntity>, GetOrdersParams> {
  final OrderRepository repository;

  GetOrders(this.repository);

  @override
  Future<Result<BaseError, List<GeneralOrderItemEntity>>> call(
      GetOrdersParams params) {
    return repository.getOrders(
      pagesize: params.pagesize ?? 0,
      page: params.page ?? 0,
      filterParams: params.filterParams ?? {},
      cancelToken: params.cancelToken,
    );
  }
}

class DeleteOrder extends UseCase<Object, DeleteOrderParams> {
  final OrderRepository repository;

  DeleteOrder(this.repository);

  @override
  Future<Result<BaseError, Object>> call(DeleteOrderParams params) {
    return repository.deleteOrder(
      id: params.id,
      cancelToken: params.cancelToken,
    );
  }
}
