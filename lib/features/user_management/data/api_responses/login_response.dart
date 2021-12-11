import 'dart:ui';
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
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends ApiResponse<LoginResultModel> {
  // @JsonKey(name: 'access_token')
  // String accessToken;
  // @JsonKey(name: 'token_type')
  // String tokenType;
  // @JsonKey(name: 'expires_at')
  // String expiresAt;

  LoginResponse(
    bool status,
    String msg,
    LoginResultModel result,
    // this.accessToken,
    // this.expiresAt,
    // this.tokenType,
  ) : super(status, msg, result);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}
