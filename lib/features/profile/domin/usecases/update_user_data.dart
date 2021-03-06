import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/base_params.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/core/usecases/usecase.dart';
import 'package:ajb1/features/profile/domin/repositories/profile_repository.dart';
import 'package:dio/dio.dart';


class UpdateUserDataParams extends BaseParams {
  final String name;
  final String email;
  final String address;
  // final String phone;
  final String aboutMe;
  final String mobile;
  final String photo;
  final String device_token;

  UpdateUserDataParams({
    required this.photo,
    required this.aboutMe,
    //   this.phone,
    required this.name,
    required this.email,
    required this.device_token,
    required this.mobile,
    required this.address,
    CancelToken? cancelToken,
  }) : super(cancelToken: cancelToken!);
}

class UpdateUserData extends UseCase<Object, UpdateUserDataParams> {
  final ProfileRepository repository;

  UpdateUserData(this.repository);

  @override
  Future<Result<BaseError, Object>> call(UpdateUserDataParams params) =>
      repository.updateProfile(
        photo: params.photo,
        //phone: params.phone,
        email: params.email,
        address: params.address,
        aboutMe: params.aboutMe,
        mobile: params.mobile,
        device_token: params.device_token,
        name: params.name,
        cancelToken: params.cancelToken,
      );
}
