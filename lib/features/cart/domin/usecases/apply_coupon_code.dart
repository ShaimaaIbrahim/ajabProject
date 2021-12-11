import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ajb1/features/cart/domin/repositories/cartr_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


class ApplyCouponCodeParams extends BaseParams {
  final String total;
  final String couponCode;

  ApplyCouponCodeParams({
    required this.total,
    required this.couponCode,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class ApplyCouponCode extends UseCase<CouponCodeEntity, ApplyCouponCodeParams> {
  final CartRepository repository;

  ApplyCouponCode(this.repository);

  @override
  Future<Result<BaseError, CouponCodeEntity>> call(
      ApplyCouponCodeParams params) {
    return repository.applyCouponCode(
      total: params.total,
      couponCode: params.couponCode,
      cancelToken: params.cancelToken,
    );
  }
}
