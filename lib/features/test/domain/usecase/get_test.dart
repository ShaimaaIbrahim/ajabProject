import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:dio/dio.dart';

class GetTestParams extends BaseParams {
  final Map<String, dynamic>? filterParams;

  GetTestParams({
    this.filterParams,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetTest extends UseCase<List<ProductEntity>, GetTestParams> {
  final ProductRepository repository;

  GetTest(this.repository);

  @override
  Future<Result<BaseError, List<ProductEntity>>> call(GetTestParams params) {
    return repository.getTestResult(
      filterParams: params.filterParams,
      cancelToken: params.cancelToken,
    );
  }
}
