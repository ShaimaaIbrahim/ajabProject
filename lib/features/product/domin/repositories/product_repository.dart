import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/repositories/repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/features/product/domin/entities/product_details_entity.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/domin/entities/product_favorite_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductRepository extends Repository {
  Future<Result<BaseError, List<ProductEntity>>> getProducts({
    int? pagesize,
    int? page,
    Map<String, String> filterParams,
    bool isFromSearchPage,
    CancelToken cancelToken,
  });
  Future<Result<BaseError, List<ProductEntity>>> getTestResult({
    Map<String, dynamic>? filterParams,
    CancelToken? cancelToken,
  });

  Future<Result<BaseError, List<ProductEntity>>> getMyProductsResult({
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, ProductDetailsEntity>> getProductDetails({
    @required int id,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, List<ProductFavoriteEntity>>> fetchFavoriteProducts({
    int? pagesize,
    int? page,
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> addOrRemoveFavorite({
    required int productID,
    CancelToken cancelToken,
  });

  Future<Result<BaseError, Object>> addReview({
    required int productID,
    required String review,
    required double rate,
    CancelToken? cancelToken,
  });
}
