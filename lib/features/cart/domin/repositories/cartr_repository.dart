import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/repositories/repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:dio/dio.dart';

abstract class CartRepository extends Repository {
  Future<Result<BaseError, CouponCodeEntity>> applyCouponCode({
    required String total,
    required String couponCode,
    CancelToken cancelToken,
  });
}
