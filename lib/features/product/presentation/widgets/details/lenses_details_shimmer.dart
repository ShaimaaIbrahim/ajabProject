import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ajb1/core/ui/items_shimmer/item_general_shimmer.dart';
import 'package:ajb1/core/ui/widget/title_with_view_all_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:ajb1/core/res/text_size.dart';
import 'package:ajb1/core/res/utils.dart';
import 'package:ajb1/core/ui/widget/image/image_caching.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/pages/lenses_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as Get;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../lens_select_size_widget.dart';

class LensesDetailsShimmer extends StatefulWidget {
  final double width;
  final double height;
  final ProductEntity product;

  const LensesDetailsShimmer({
    required this.height,
    required this.width,
    required this.product,
  });

  @override
  _LensesDetailsShimmerState createState() => _LensesDetailsShimmerState();
}

class _LensesDetailsShimmerState extends State<LensesDetailsShimmer> {
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;

  /// frame Height parameters
  bool _frameHeightValidation = false;
  String _frameHeight = '';
  final TextEditingController frameHeightEditingController =
      new TextEditingController();

  /// frame Width parameters
  bool _frameWidthValidation = false;
  String _frameWidth = '';
  final TextEditingController frameWidthEditingController =
      new TextEditingController();

  /// frame Length parameters
  bool _frameLengthValidation = false;
  String _frameLength = '';
  final TextEditingController frameLengthEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? globalSize.setWidthPercentage(100, context);
    final height =
        widget.height ?? globalSize.setHeightPercentage(100, context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: Colors.grey[200]),
      child: SingleChildScrollView(
        child: BaseShimmerWidget(
          child: Column(
              children: [
                _buildTopAds(context: context, height: 150.h),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 20.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]),
                        )
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      _buildShareFavorite(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 50.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                              color: Colors.grey[500]),
                        )
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Container(
                        height: 70.h,
                        child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: 70.w,
                                height: 70.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20.r)),
                                    color: Colors.grey[500]),
                                margin: EdgeInsets.only(left: 5.w, right: 5.w),
                                // child: CachedNetworkImage(
                                //   fit: BoxFit.cover,
                                //   imageUrl:
                                //   'https://image.freepik.com/free-photo/beef-burger-with-chopped-onions-tomatoes-inside-bread-bun-with-french-fries-stone-platter_114579-1865.jpg',
                                // ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select Size',
                          style: textStyle.middleTSBasic.copyWith(
                              color: globalColor.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _buildSizesWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 30.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                              color: Colors.grey[200]),
                        )
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child:Container(
                          width: 100.w,
                          height: 10.h,
                          decoration: BoxDecoration(
                              color: Colors.grey[200]),
                        )
                      ),

                    ],
                  ),
                )]
          ),
        ),
      ),
    );
  }
  _buildShareFavorite() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.share,
              color: Colors.grey,
            ),
            SizedBox(
              width: 20.w,
            ),
            Icon(
              Icons.favorite,
              color: Colors.grey,
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 30.w,
          height: 10.h,
          decoration: BoxDecoration(
              color: Colors.grey[200]),
        )
      ],
    );
  }

  _buildTopAds({required BuildContext context, required double height}) {
    return Container(
        height: 150.h,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0.h,
              left: 0.w,
              right: 0.w,
              child: Container(
                height: 200.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                    color: Colors.indigo),
              ),
            ),
            Positioned(
              top: 20.h,
              left: 20.w,
              right: 20.w,
              child: Container(
                height: 180.h,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[500],
                // child: ListView.builder(
                //     itemCount: 5,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container(
                //         decoration: BoxDecoration(
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(20.r)),
                //             color: Colors.white),
                //         child: CachedNetworkImage(
                //           imageUrl:
                //           'https://image.freepik.com/free-photo/beef-burger-with-chopped-onions-tomatoes-inside-bread-bun-with-french-fries-stone-platter_114579-1865.jpg',
                //         ),
                //       );
                //     }),
              ),
            )
          ],
        ));
  }

  _buildSizesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              flex: 1,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.black),
                    borderRadius:
                    BorderRadius.all(Radius.circular(10.r)),
                    color: Colors.white),
                child: Center(
                  child: Text(
                    '4.0',
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
