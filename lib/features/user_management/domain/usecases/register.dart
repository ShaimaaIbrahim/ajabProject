import 'package:ajb1/features/user_management/data/api_requests/register_request.dart';
import 'package:ajb1/features/user_management/domain/entities/register_result.dart';
import 'package:dio/dio.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

class RegisterParams extends BaseParams {
  RegisterRequest bodyParam;

  RegisterParams({
    required this.bodyParam,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class RegisterUseCase extends UseCase<RegisterResult, RegisterParams> {
  final UserRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Result<BaseError, RegisterResult>> call(RegisterParams params) =>
      repository.register(
        data: params.bodyParam,
        cancelToken: params.cancelToken,
      );
}
