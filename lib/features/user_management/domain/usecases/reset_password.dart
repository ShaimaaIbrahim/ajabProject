import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

class ResetPasswordParams extends BaseParams {
  final ResetPasswordRequest data;

  ResetPasswordParams({
    required this.data,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class ResetPassword extends UseCase<Object, ResetPasswordParams> {
  final UserRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ResetPasswordParams params) =>
      repository.resetPassword(
        data: params.data,
        cancelToken: params.cancelToken,
      );
}
