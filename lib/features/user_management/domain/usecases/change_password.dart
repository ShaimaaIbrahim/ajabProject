import 'package:dio/dio.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

class ChangePasswordParams extends BaseParams {
  final Map<String, dynamic> queryParameters;

  ChangePasswordParams({
    required this.queryParameters,
    CancelToken? cancelToken,
  })  : assert(cancelToken != null),
        super(cancelToken: cancelToken!);
}

class ChangePasswordUseCase extends UseCase<Object, ChangePasswordParams> {
  final UserRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ChangePasswordParams params) =>
      repository.changePassword(
        queryParameters: params.queryParameters,
        cancelToken: params.cancelToken,
      );
}
