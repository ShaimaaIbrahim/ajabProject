import 'package:ajb1/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ajb1/features/user_management/domain/entities/forget_result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';

class ForgotPasswordParams extends BaseParams {
  final ForgotPasswordRequest data;

  ForgotPasswordParams({
    required this.data,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class ForgotPassword extends UseCase<ForgetResult, ForgotPasswordParams> {
  final UserRepository repository;

  ForgotPassword(this.repository);

  @override
  Future<Result<BaseError, ForgetResult>> call(ForgotPasswordParams params) {
    print(params);
    return repository.forgotPassword(
      data: params.data,
      cancelToken: params.cancelToken,
    );
  }
}
