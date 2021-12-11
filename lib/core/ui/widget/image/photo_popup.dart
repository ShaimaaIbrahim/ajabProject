import 'package:ajb1/core/ui/widget/image/photo_details.dart';
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
import 'package:uuid/uuid.dart';

import '../../../appConfig.dart';

class PhotoPopup extends StatefulWidget {
  final String? imageUrl;
  final double imageHeight;
  final double imageWidth;
  final bool isCached;
  final double imageBorderRadius;

  const PhotoPopup(
      {required this.imageUrl,
      required this.imageHeight,
      required this.imageWidth,
      required this.imageBorderRadius,
      this.isCached = false});

  @override
  _PhotoPopupState createState() => _PhotoPopupState();
}

class _PhotoPopupState extends State<PhotoPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  static final uuid = Uuid();
  final String imgTag = uuid.v4();

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (appConfig.notNullOrEmpty(widget.imageUrl!))
          _goToDetail(
              widget.imageUrl ?? '', '${(widget.imageUrl ?? '') + imgTag}');
      },
      child: Hero(
        tag: '${(widget.imageUrl ?? '') + imgTag}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.imageBorderRadius),
          child: Container(
              width: widget.imageWidth,
              height: widget.imageHeight,
              child: CachedNetworkImage(
                imageUrl: widget.imageUrl ?? '',
                width: widget.imageWidth,
                height: widget.imageHeight,
                fadeOutDuration: Duration(milliseconds: 500),
                fadeInCurve: Curves.easeInOut,
                fadeInDuration: Duration(milliseconds: 500),
                fadeOutCurve: Curves.easeInOut,
                fit: BoxFit.cover,
                placeholder: (context, _) {
                  return Container(
                      width: widget.imageWidth,
                      height: widget.imageHeight,
                      child: Image.asset(
                        'assets/images/dark_background2.png',
                        fit: BoxFit.fill,
                        width: widget.imageWidth,
                        height: widget.imageHeight,
                      ));
                },
                errorWidget: (context, url, error) => Container(
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  child: Image.asset(
                    'assets/images/dark_background2.png',
                    width: widget.imageWidth,
                    height: widget.imageHeight,
                    fit: BoxFit.fill,
                  ),
                ),
              )),
        ),
      ),
    );
  }

  void _goToDetail(String image, String tag) async {
    final page = PhotoDetailPage(
      image: image,
      tag: tag,
    );
    await Navigator.of(context).push(
      PageRouteBuilder<Null>(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: page,
          );
        },
        transitionDuration: Duration(milliseconds: 700),
      ),
    );
  }
}
