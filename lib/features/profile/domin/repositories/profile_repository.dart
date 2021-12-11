import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/repositories/repository.dart';
import 'package:ajb1/core/results/result.dart';
import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';



abstract class ProfileRepository extends Repository {

  Future<Result<BaseError, ProfileEntity>> getUserData({
    CancelToken cancelToken,
  });

  Future<Result<BaseError, ProfileEntity>> updateProfile({
    String name,
    String email,
    String address,
    String mobile,
   String device_token,
    String aboutMe,
    String photo,
    CancelToken cancelToken,
  });
}
