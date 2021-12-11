import 'package:ajb1/core/entities/offer_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:dio/dio.dart';

import 'usecase.dart';

class GetOffers extends UseCase<OfferEntity, NoParams> {
  final CoreRepository repository;

  GetOffers(this.repository);

  @override
  Future<Result<BaseError, OfferEntity>> call(NoParams params) =>
      repository.getOffers(cancelToken: params.cancelToken);
}
