import 'package:ajb1/core/entities/shipping_carriers_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';

import 'usecase.dart';

class GetShippingCarriers
    extends UseCase<List<ShippingCarriersEntity>, NoParams> {
  final CoreRepository repository;

  GetShippingCarriers(this.repository);

  @override
  Future<Result<BaseError, List<ShippingCarriersEntity>>> call(
          NoParams params) =>
      repository.getShippingCarriers(cancelToken: params.cancelToken);
}
