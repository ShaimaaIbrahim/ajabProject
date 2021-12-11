import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ReSendCodeParams extends BaseParams {
  final String mobile;
  final String device_token;

  ReSendCodeParams({
    required this.mobile,
    required this.device_token,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class ReSendCode extends UseCase<Object, ReSendCodeParams> {
  final UserRepository repository;

  ReSendCode(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ReSendCodeParams params) =>
      repository.reSendCode(
        username: params.mobile,
        device_token: params.device_token,
        cancelToken: params.cancelToken,
      );
}
