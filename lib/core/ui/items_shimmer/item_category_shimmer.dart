import 'dart:math';

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
import 'base_shimmer.dart';

class ItemCategoryShimmer extends StatefulWidget {
  final double? width;
  final double? height;

  const ItemCategoryShimmer({this.height, this.width});

  @override
  State<StatefulWidget> createState() {
    return _ItemCategoryShimmerState();
  }
}

class _ItemCategoryShimmerState extends State<ItemCategoryShimmer> {
  late int randomWidth;
  late int randomHeight;

  @override
  void initState() {
    super.initState();
    generateRandomNumber();
  }

  void generateRandomNumber() {
    var rand = new Random();
    int next(int min, int max) => min + rand.nextInt(max - min);

    setState(() {
      randomWidth = next(20, 60);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthC = widget.width ?? globalSize.setWidthPercentage(22, context);
    double heightC =
        widget.height ?? globalSize.setWidthPercentage(25, context);

    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Container(
        width: widthC,
        height: heightC,
        child: Container(
            width: widthC,
            height: heightC,
            child: BaseShimmerWidget(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        width: widthC * .8,
                        height: widthC * .8,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: randomWidth.toDouble(),
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
