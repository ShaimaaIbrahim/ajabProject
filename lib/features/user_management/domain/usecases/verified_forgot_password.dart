import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class VerifiedForgetPasswordParams extends BaseParams {
  final Map<String, dynamic> queryParameters;

  VerifiedForgetPasswordParams({
    required this.queryParameters,
    CancelToken? cancelToken,
  })  : assert(cancelToken != null),
        super(cancelToken: cancelToken!);
}

class VerifiedForgetPasswordUseCase
    extends UseCase<Object, VerifiedForgetPasswordParams> {
  final UserRepository repository;

  VerifiedForgetPasswordUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(VerifiedForgetPasswordParams params) =>
      repository.verifiedForgotPassword(
        queryParameters: params.queryParameters,
        cancelToken: params.cancelToken,
      );
}
