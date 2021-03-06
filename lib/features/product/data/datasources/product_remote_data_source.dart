import 'package:ajb1/core/datasources/remote_data_source.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/features/product/data/models/product_details_model.dart';
import 'package:ajb1/features/product/data/models/product_favorite_model.dart';
import 'package:ajb1/features/product/data/models/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<ProductModel>>> fetchProducts({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    bool isFromSearchPage,
    CancelToken cancelToken,
  });
  Future<Either<BaseError, List<ProductModel>>> getTestResult({
    Map<String, dynamic> filterParams,
    CancelToken cancelToken,
  });
  Future<Either<BaseError, List<ProductModel>>> getMyProductsResult({
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, ProductDetailsModel>> fetchProductDetails({
    @required int id,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, List<ProductFavoriteModel>>> fetchFavoriteProducts({
    int pagesize,
    int page,
    Map<String, String> filterParams,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> addOrRemoveFavorite({
    @required int productID,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> addReview({
    @required int productID,
    @required String review,
    @required double rate,
    CancelToken cancelToken,
  });
}
