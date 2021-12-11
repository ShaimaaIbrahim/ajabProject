import 'package:ajb1/core/constants.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/http/http_method.dart';
import 'package:ajb1/features/cart/data/api_responses/coupon_code_response.dart';
import 'package:ajb1/features/cart/data/models/coupon_code_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'cart_remote_data_source.dart';


class ConcreteCartRemoteDataSource extends CartRemoteDataSource {
  @override
  Future<Either<BaseError, CouponCodeModel>> applyCouponCode({
    String? total,
    String? couponCode,
    CancelToken? cancelToken,
  }) {
    return request<CouponCodeModel, CouponCodeResponse>(
      responseStr: 'CouponCodeResponse',
      converter: (json) => CouponCodeResponse.fromJson(json),
      method: HttpMethod.POST,
      url: API_EXECUTE_COUPON,
      withAuthentication: true,
      data: {'couponcode': couponCode, 'total': total},
      cancelToken: cancelToken!,
    );
  }
}
