import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';


class DeleteNotificationParams extends BaseParams {
  String id;

  DeleteNotificationParams({
    required this.id,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class DeleteNotificationUseCase
    extends UseCase<Object, DeleteNotificationParams> {
  final CoreRepository repository;

  DeleteNotificationUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(DeleteNotificationParams params) =>
      repository.deleteNotification(
        id: params.id,
        cancelToken: params.cancelToken,
      );
}
