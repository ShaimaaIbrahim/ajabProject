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

PopupMenuEntry<dynamic> menuGeneralItem(
    {required String title, required Function() onClick}) {
  return PopupMenuItem(
    height: ScreenUtil().setHeight(40),
    child: InkWell(
        splashColor: Colors.white,
        highlightColor: Colors.white,
        onTap: onClick,
        child: Container(
          height: ScreenUtil().setHeight(40),
          child: Row(
            children: <Widget>[
              SizedBox(width: 4),
              Container(
                child: Text(title,
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.white)),
              ),
            ],
          ),
        )),
  );
}
