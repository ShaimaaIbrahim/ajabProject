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
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse extends ApiResponse<RegisterResultModel> {
  RegisterResponse(
    bool status,
    String msg,
    RegisterResultModel result,
  ) : super(status, msg, result);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}
