




import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:ajb1/features/profile/domin/repositories/profile_repository.dart';

class GetUserDetails extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository repository;

  GetUserDetails(this.repository);

  @override
  Future<Result<BaseError, ProfileEntity>> call(NoParams params) {
    return repository.getUserData(
      cancelToken: params.cancelToken,
    );
  }
}
