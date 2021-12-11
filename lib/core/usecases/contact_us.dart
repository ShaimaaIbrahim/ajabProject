import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';

import 'package:dio/dio.dart';


class ContactUsParams extends BaseParams {
  String name;
  String phone;
  String message;

  ContactUsParams({
    required this.name,
    required this.phone,
    required this.message,
    required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class ContactUsUseCase extends UseCase<Object, ContactUsParams> {
  final CoreRepository repository;

  ContactUsUseCase(this.repository);

  @override
  Future<Result<BaseError, Object>> call(ContactUsParams params) =>
      repository.contactUs(
        phone: params.phone,
        name: params.name,
        message: params.message,
        cancelToken: params.cancelToken,
      );
}
