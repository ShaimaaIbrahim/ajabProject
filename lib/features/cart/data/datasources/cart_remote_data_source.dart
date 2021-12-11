import 'package:ajb1/core/datasources/remote_data_source.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/features/cart/data/models/coupon_code_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';



abstract class CartRemoteDataSource extends RemoteDataSource {

  Future<Either<BaseError, CouponCodeModel>> applyCouponCode({
    @required String total,
    @required String couponCode,
    CancelToken cancelToken,
  });
}
