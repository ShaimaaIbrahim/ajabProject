import 'package:ajb1/core/res/text_size.dart';
import 'package:flutter/material.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/features/user_management/presentation/pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as Get;
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/icon_size.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class GlobalDecorations {
  static InputDecoration get kNormalFieldInputDecoration => InputDecoration(
      labelStyle: textStyle.smallTSBasic.copyWith(color: globalColor.textLabel),
      errorStyle: textStyle.smallTSBasic.copyWith(
        color: Colors.red,
        fontSize: textSize.subMin,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: globalColor.enabledBorder),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: globalColor.focusedBorder),
      ));

  static InputDecoration get normalFieldUerManagementNInputDecoration =>
      InputDecoration(
        hintStyle: TextStyle(color: globalColor.grey),
        alignLabelWithHint: true,
        fillColor: globalColor.white,
        filled: true,
        labelStyle:
            textStyle.smallTSBasic.copyWith(color: globalColor.textLabel),
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.subMin,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      );

  static InputDecoration get kBorderFieldInputDecoration => InputDecoration(
        alignLabelWithHint: false,
        labelStyle: textStyle.normalTSBasic,
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.subMin,
        ),
        filled: false,
      );

  static InputDecoration get underLineVerificationCOdeFieldInputDecoration =>
      InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalColor.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: globalColor.primaryColor, width: 4),
          borderRadius: BorderRadius.only(),
        ),
        filled: false,
        errorStyle: textStyle.smallTSBasic.copyWith(
          color: Colors.red,
          fontSize: textSize.middle,
        ),
      );
}
