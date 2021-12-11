import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/order/domain/entities/city_order_entity.dart';
import 'package:dio/dio.dart';
import 'usecase.dart';

class GetCities extends UseCase<List<CityOrderEntity>, NoParams> {
  final CoreRepository repository;

  GetCities(this.repository);

  @override
  Future<Result<BaseError, List<CityOrderEntity>>> call(NoParams params) =>
      repository.getCities(cancelToken: params.cancelToken);
}
