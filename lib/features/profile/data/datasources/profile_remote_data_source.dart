import 'package:ajb1/core/datasources/remote_data_source.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/features/profile/data/models/profile_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';



abstract class ProfileRemoteDataSource extends RemoteDataSource {

  Future<Either<BaseError, ProfileModel>> getUserData({
    CancelToken cancelToken,
  });

  Future<Either<BaseError, ProfileModel>> updateProfile({
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
