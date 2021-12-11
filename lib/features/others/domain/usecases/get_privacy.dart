import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/others/domain/entity/privacy_result.dart';
import 'package:dio/dio.dart';


class GetPrivacyAppParams extends BaseParams {
  final bool isPrivacyApp;
  GetPrivacyAppParams({
    this.isPrivacyApp = false,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class GetPrivacyApp extends UseCase<PrivacyAppResult, GetPrivacyAppParams> {
  final CoreRepository repository;

  GetPrivacyApp(this.repository);

  @override
  Future<Result<BaseError, PrivacyAppResult>> call(GetPrivacyAppParams params) {
    return repository.getPrivacyAppInfo(
      isPrivacy: params.isPrivacyApp,
      cancelToken: params.cancelToken,
    );
  }
}
