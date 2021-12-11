import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AddOrRemoveFavoriteParams extends BaseParams {
  final int productId;

  AddOrRemoveFavoriteParams({
    required this.productId,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class AddOrRemoveFavorite extends UseCase<Object, AddOrRemoveFavoriteParams> {
  final ProductRepository repository;

  AddOrRemoveFavorite(this.repository);

  @override
  Future<Result<BaseError, Object>> call(AddOrRemoveFavoriteParams params) {
    return repository.addOrRemoveFavorite(
      productID: params.productId,
      cancelToken: params.cancelToken,
    );
  }
}
