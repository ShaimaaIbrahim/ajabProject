
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:dio/dio.dart';


class GetMyProductsParams extends BaseParams {
  final Map<String, String>? filterParams;

  GetMyProductsParams({
    this.filterParams,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetMyProducts extends UseCase<List<ProductEntity>, GetMyProductsParams> {
  final ProductRepository repository;

  GetMyProducts(this.repository);

  @override
  Future<Result<BaseError, List<ProductEntity>>> call(
      GetMyProductsParams params) {
    return repository.getMyProductsResult(
      filterParams: params.filterParams!,
      cancelToken: params.cancelToken,
    );
  }
}
