

import 'package:ajb1/core/entities/category_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';

import 'usecase.dart';

class GetCategories extends UseCase<List<CategoryEntity>, NoParams> {
  final CoreRepository repository;

  GetCategories(this.repository);

  @override
  Future<Result<BaseError, List<CategoryEntity>>> call(NoParams params) =>
      repository.getCategories(cancelToken: params.cancelToken);
}
