import 'package:ajb1/core/res/width_height.dart';
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

import '../base_shimmer.dart';

class HomeAdsItemShimmer extends StatelessWidget {
  final double? width;
  final double? height;

  HomeAdsItemShimmer({this.width = 100, this.height});

  @override
  Widget build(BuildContext context) {
    double widthC = width ?? globalSize.setWidthPercentage(100, context);
    double heightC = height ?? globalSize.setWidthPercentage(50, context);

    return BaseShimmerWidget(
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: EdgeMargin.sub,
          horizontal: EdgeMargin.sub,
        ),
        width: widthC,
        height: heightC,
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widthC * .03),
            topRight: Radius.circular(widthC * .03),
            bottomRight: Radius.circular(widthC * .03),
            bottomLeft: Radius.circular(widthC * .03),
          ),
          //   shape: BoxShape.circle,
        ),
      ),
    );
  }
}
