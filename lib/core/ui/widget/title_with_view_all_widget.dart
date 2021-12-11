import 'package:ajb1/core/res/utils.dart';
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

class TitleWithViewAllWidget extends StatelessWidget {
  final double width;
  final String title;
  final String strViewAll;
  final Function() onClickView;
  final TextStyle? style;
  final bool hideSeeAll;

  const TitleWithViewAllWidget(
      {required this.title,
      required this.width,
      required this.onClickView,
      required this.strViewAll,
      this.style,
      this.hideSeeAll = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              title,
              style: style ??
                  textStyle.middleTSBasic.copyWith(
                    color: globalColor.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          hideSeeAll
              ? Container()
              : InkWell(
                  onTap: onClickView,
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          Translations.of(context).translate("view_all"),
                          style: textStyle.smallTSBasic.copyWith(
                              color: globalColor.grey,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(
                          utils.getLang() == 'ar'
                              ? Icons.keyboard_arrow_left
                              : Icons.keyboard_arrow_right,
                          color: globalColor.black,
                          size: 17.w,
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
