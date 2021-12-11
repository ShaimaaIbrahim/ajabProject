import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/others/domain/entity/about_app_result.dart';
import 'package:dio/dio.dart';

class GetAboutAppParams extends BaseParams {
  GetAboutAppParams({
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetAboutApp extends UseCase<AboutAppResult, GetAboutAppParams> {
  final CoreRepository repository;

  GetAboutApp(this.repository);

  @override
  Future<Result<BaseError, AboutAppResult>> call(GetAboutAppParams params) {
    return repository.getAboutAppInfo(
      cancelToken: params.cancelToken,
    );
  }
}
