import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/order/domain/repositories/order_repository.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

class DeleteOrderParams extends BaseParams {
  int id;

  DeleteOrderParams({
    required this.id,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class DeleteOrderUseCase extends UseCase<Object, DeleteOrderParams> {
  final OrderRepository repository;

  DeleteOrderUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(DeleteOrderParams params) =>
      repository.deleteOrder(
        id: params.id,
        cancelToken: params.cancelToken,
      );
}
