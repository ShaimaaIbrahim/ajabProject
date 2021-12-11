import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

class SetNotificationParams extends BaseParams {
  bool notify_new_product;
  bool notify_wallet;
  bool notify_offer;

  SetNotificationParams({
    required this.notify_new_product,
    required this.notify_wallet,
    required this.notify_offer,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class SetNotificationUseCase extends UseCase<Object, SetNotificationParams> {
  final CoreRepository repository;

  SetNotificationUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(SetNotificationParams params) =>
      repository.setNotification(
        notify_offer: params.notify_offer,
        notify_wallet: params.notify_wallet,
        notify_new_product: params.notify_new_product,
        cancelToken: params.cancelToken,
      );
}
