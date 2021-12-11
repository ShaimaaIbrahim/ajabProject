import 'package:ajb1/core/datasources/remote_data_source.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/features/user_management/data/api_requests/forgot_password_request.dart';
import 'package:ajb1/features/user_management/data/api_requests/login_request.dart';
import 'package:ajb1/features/user_management/data/api_requests/register_request.dart';
import 'package:ajb1/features/user_management/data/api_requests/reset_password_request.dart';
import 'package:ajb1/features/user_management/data/api_requests/verify_request.dart';
import 'package:ajb1/features/user_management/data/models/forget_result_model.dart';
import 'package:ajb1/features/user_management/data/models/login_result_model.dart';
import 'package:ajb1/features/user_management/data/models/register_result_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:ajb1/features/user_management/data/models/register_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dart:ui';

import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/utils.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:ajb1/features/user_management/data/models/login_result_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/ui/widget/text/normal_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/global_color.dart';

abstract class UserRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, RegisterResultModel>> register({
    @required RegisterRequest data,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> verify({
    VerifyRequest data,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> reSendCode({
    @required String username,
    @required String device_token,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, LoginResultModel>> login({
    LoginRequest data,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> forgetPassword({
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  });

  ///===========================================================================

  // Future<Either<BaseError, VerifyResultModel>> registerPhoneNumber({
  //   @required Map<String, dynamic> data,
  //   CancelToken cancelToken,
  // });

  Future<Either<BaseError, Object>> resendCode({
    @required Map<String, dynamic> queryParameters,
    @required String urlResendCode,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> verifiedForgotPassword({
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> changePassword({
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, ForgetResultModel>> forgotPassword({
    @required ForgotPasswordRequest data,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> resetPassword({
    @required ResetPasswordRequest data,
    CancelToken cancelToken,
  });

  Future<Either<BaseError, Object>> changeUserNamePhoneNumberOrEmail({
    Map<String, dynamic> queryParameters,
    String changeUserNameUrl,
    CancelToken cancelToken,
  });
}
