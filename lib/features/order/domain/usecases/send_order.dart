import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/order/data/requests/order_request.dart';
import 'package:ajb1/features/order/domain/repositories/order_repository.dart';
import 'package:dio/dio.dart';

class SendOrdersParams extends BaseParams {
  final OrderRequest? request;

  SendOrdersParams({
    this.request,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class SendOrders extends UseCase<Object, SendOrdersParams> {
  final OrderRepository repository;

  SendOrders(this.repository);

  @override
  Future<Result<BaseError, Object>> call(SendOrdersParams params) {
    return repository.sendOrder(
      request: params.request!,
      cancelToken: params.cancelToken,
    );
  }
}
