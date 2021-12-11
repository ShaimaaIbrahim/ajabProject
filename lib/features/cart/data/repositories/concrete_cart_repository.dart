import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/features/cart/data/datasources/cart_remote_data_source.dart';
import 'package:ajb1/features/cart/data/models/coupon_code_model.dart';
import 'package:ajb1/features/cart/domin/entities/coupon_code_entity.dart';
import 'package:ajb1/features/cart/domin/repositories/cartr_repository.dart';
import 'package:dio/dio.dart';


class ConcreteCartRepository extends CartRepository {
  final CartRemoteDataSource remoteDataSource;

  ConcreteCartRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, CouponCodeEntity>> applyCouponCode({
    String? total,
    String? couponCode,
    CancelToken? cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.applyCouponCode(
      total: total!,
      couponCode: couponCode!,
      cancelToken: cancelToken!,
    );
    return execute<CouponCodeModel, CouponCodeEntity>(
        remoteResult: remoteResult);
  }
}
