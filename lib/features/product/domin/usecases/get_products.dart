import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:dio/dio.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class GetProductParams extends BaseParams {
  final Map<String, String> filterParams;
  final int? pagesize;
  final int? page;
  final bool isFromSearchPage;

  GetProductParams({
    required this.filterParams,
    this.pagesize,
    this.page,
    this.isFromSearchPage = false,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetProduct extends UseCase<List<ProductEntity>, GetProductParams> {
  final ProductRepository repository;

  GetProduct(this.repository);

  @override
  Future<Result<BaseError, List<ProductEntity>>> call(GetProductParams params) {
    return repository.getProducts(
      pagesize: params.pagesize,
      page: params.page,
      filterParams: params.filterParams,
      isFromSearchPage: params.isFromSearchPage,
      cancelToken: params.cancelToken,
    );
  }
}
