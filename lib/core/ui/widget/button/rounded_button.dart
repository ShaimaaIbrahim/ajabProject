import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class RoundedButton extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget child;
  final Color? color;
  final Function()? onPressed;

  const RoundedButton(
      {Key? key,
      required this.child,
      this.color,
      this.height,
      this.width,
      this.borderRadius = 0.0,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: this.width ?? 200.w,
      height: height ?? 45.h,
      child: RaisedButton(
          padding: const EdgeInsets.all(8.0),
          color: color ?? globalColor.white,
          onPressed: onPressed ?? () {},
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          child: child),
    );
  }
}
