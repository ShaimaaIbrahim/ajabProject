import 'package:ajb1/features/user_management/data/api_requests/login_request.dart';
import 'package:ajb1/features/user_management/domain/entities/login_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class LoginParams extends BaseParams {
  final LoginRequest data;
  final bool isRememberMe;

  LoginParams({
    required this.data,
    required this.isRememberMe,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class LoginUseCase extends UseCase<LoginResult, LoginParams> {
  final UserRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Result<BaseError, LoginResult>> call(LoginParams params) =>
      repository.login(
        data: params.data,
        // isRememberMe: params.isRememberMe,
        cancelToken: params.cancelToken,
      );
}
