import 'package:ajb1/core/entities/faqs_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';

import 'usecase.dart';

class GetFaqs extends UseCase<List<FaqsEntity>, NoParams> {
  final CoreRepository repository;

  GetFaqs(this.repository);

  @override
  Future<Result<BaseError, List<FaqsEntity>>> call(NoParams params) =>
      repository.getFAQS(cancelToken: params.cancelToken);
}
