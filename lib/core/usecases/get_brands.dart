

import 'package:ajb1/core/entities/brand_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';
import 'usecase.dart';

class GetBrands extends UseCase<List<BrandEntity>, NoParams> {
  final CoreRepository repository;

  GetBrands(this.repository);

  @override
  Future<Result<BaseError, List<BrandEntity>>> call(NoParams params) =>
      repository.getBrands(cancelToken: params.cancelToken);
}
