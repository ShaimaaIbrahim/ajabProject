import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/data/api_requests/verify_request.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class VerifyParams extends BaseParams {
  final VerifyRequest data;

  VerifyParams({
    required this.data,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class Verify extends UseCase<Object, VerifyParams> {
  final UserRepository repository;

  Verify(this.repository);

  @override
  Future<Result<BaseError, Object>> call(VerifyParams params) =>
      repository.verify(
        data: params.data,
        cancelToken: params.cancelToken,
      );
}
