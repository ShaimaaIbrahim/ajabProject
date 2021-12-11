import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AddReviewParams extends BaseParams {
  final int productId;
  final String review;
  final double rate;

  AddReviewParams({
    required this.productId,
    required this.rate,
    required this.review,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class AddReview extends UseCase<Object, AddReviewParams> {
  final ProductRepository repository;

  AddReview(this.repository);

  @override
  Future<Result<BaseError, Object>> call(AddReviewParams params) {
    return repository.addReview(
      productID: params.productId,
      rate: params.rate,
      review: params.review,
      cancelToken: params.cancelToken,
    );
  }
}
