import 'package:ajb1/core/res/width_height.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

class PhotoDetailPage extends StatefulWidget {
  final String? image;
  final String tag;

  const PhotoDetailPage({Key? key, required this.image, required this.tag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PhotoDetailStat();
  }
}

class _PhotoDetailStat extends State<PhotoDetailPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 400),
        lowerBound: 0.0,
        upperBound: 1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context);
    return Scaffold(
      backgroundColor: globalColor.basic1.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: globalColor.basic1.withOpacity(0.9),
          padding: const EdgeInsets.all(18.0),
          width: widthC,
          height: heightC,
          child: Center(
            child: Hero(
                tag: widget.tag,
                child: CachedNetworkImage(
                  imageUrl: widget.image ?? '',
                  width: widthC,
                  height: heightC * .5,
                  fadeOutDuration: Duration(milliseconds: 500),
                  fadeInCurve: Curves.easeInOut,
                  fadeInDuration: Duration(milliseconds: 500),
                  fadeOutCurve: Curves.easeInOut,
                  fit: BoxFit.cover,
                  placeholder: (context, _) {
                    return Container(
                        height: widthC,
                        width: heightC * .5,
                        child: Image.asset(
                          'assets/images/dark_background2.png',
                          fit: BoxFit.fill,
                          width: widthC,
                          height: heightC * .5,
                        ));
                  },
                )),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
