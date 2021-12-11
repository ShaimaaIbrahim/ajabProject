import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/cart/domin/entities/payment_method_entity.dart';
import 'package:dio/dio.dart';

import 'usecase.dart';

class GetPaymentMethods extends UseCase<List<PaymentMethodEntity>, NoParams> {
  final CoreRepository repository;

  GetPaymentMethods(this.repository);

  @override
  Future<Result<BaseError, List<PaymentMethodEntity>>> call(NoParams params) =>
      repository.getPaymentMethods(cancelToken: params.cancelToken);
}
