import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/ui/widget/image/image_caching.dart';
import 'package:ajb1/features/product/domin/entities/general_item_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import '../args/product_list_args.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemColorWidget extends StatelessWidget {
  final GeneralItemEntity color;
  const ItemColorWidget({required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                border: Border.all(
                    width: 0.5, color: globalColor.grey.withOpacity(0.3)),
                color: globalColor.white.withOpacity(0.5)),
            width: 28.w,
            height: 28.w,
            child: Center(
              child: Container(
                width: 22.w,
                height: 22.w,
                child: ImageCacheWidget(
                  imageUrl: color.image ?? '',
                  imageWidth: 22.w,
                  imageHeight: 22.w,
                  imageBorderRadius: 22.w,
                  boxFit: BoxFit.fill,
                ),
                // decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     //color: globalColor.grey.withOpacity(0.5),
                //     gradient: LinearGradient(
                //         begin: AlignmentDirectional.bottomEnd,
                //         end: AlignmentDirectional.topStart,
                //         colors: [
                //           globalColor.primaryColor,
                //           globalColor.primaryColor.withOpacity(0.9),
                //           globalColor.primaryColor.withOpacity(0.8),
                //           globalColor.primaryColor.withOpacity(0.7),
                //           globalColor.primaryColor,
                //           globalColor.primaryColor.withOpacity(0.9),
                //           globalColor.primaryColor.withOpacity(0.8),
                //           globalColor.primaryColor.withOpacity(0.7),
                //           globalColor.primaryColor,
                //           globalColor.primaryColor.withOpacity(0.9),
                //           globalColor.primaryColor.withOpacity(0.8),
                //           globalColor.primaryColor.withOpacity(0.7),
                //         ])),
              ),
            ),
          ),
          HorizontalPadding(
            percentage: 1.0,
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 45),
            child: Text(
              color.name,
              style: textStyle.minTSBasic.copyWith(
                  color: globalColor.black, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Container(
          //   child: Center(
          //     child: Icon(
          //       MaterialIcons.keyboard_arrow_down,
          //       color: globalColor.globalDarkGrey,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
