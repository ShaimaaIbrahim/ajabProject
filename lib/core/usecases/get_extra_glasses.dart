import 'package:ajb1/core/entities/extra_glasses_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';

import 'usecase.dart';

class GetExtraGlasses extends UseCase<ExtraGlassesEntity, NoParams> {
  final CoreRepository repository;

  GetExtraGlasses(this.repository);

  @override
  Future<Result<BaseError, ExtraGlassesEntity>> call(NoParams params) =>
      repository.getExtraGlasses(cancelToken: params.cancelToken);
}
