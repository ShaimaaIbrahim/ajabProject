import 'package:ajb1/core/entities/notifications_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';

import 'usecase.dart';

class GetNotifications extends UseCase<List<NotificationsEntity>, NoParams> {
  final CoreRepository repository;

  GetNotifications(this.repository);

  @override
  Future<Result<BaseError, List<NotificationsEntity>>> call(NoParams params) =>
      repository.getNotifications(cancelToken: params.cancelToken);
}
