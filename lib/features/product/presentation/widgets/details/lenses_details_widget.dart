import 'package:ajb1/core/bloc/application_bloc.dart';
import 'package:ajb1/features/product/domin/entities/general_item_entity.dart';
import 'package:ajb1/features/product/domin/entities/product_details_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class LensesDetailsWidget extends StatefulWidget {
  final double width;
  final double height;
  final ProductEntity product;
  final ProductDetailsEntity productDetails;
  final CancelToken cancelToken;

  const LensesDetailsWidget(
      {required this.height,
      required this.width,
      required this.product,
      required this.productDetails,
      required this.cancelToken});

  @override
  _LensesDetailsWidgetState createState() => _LensesDetailsWidgetState();
}

class _LensesDetailsWidgetState extends State<LensesDetailsWidget> {
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;


  GeneralItemEntity? _colorSelect;


  bool? isAuth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _colorSelect = widget.product?.colorInfo?.first;
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? globalSize.setWidthPercentage(100, context);
    final height =
        widget.height ?? globalSize.setHeightPercentage(100, context);
    isAuth =
        BlocProvider.of<ApplicationBloc>(context).state.isUserAuthenticated ||
            BlocProvider.of<ApplicationBloc>(context).state.isUserVerified;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: Colors.grey[200]),
      child: SingleChildScrollView(
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
                    child: Text(
                      '1/7',
                      style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                      child: Text(
                      'Nike Air Max 2663',
                      style: textStyle.middleTSBasic.copyWith(
                          color: globalColor.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp),
                    ),
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
                                color: Colors.white),
                            margin: EdgeInsets.only(left: 5.w, right: 5.w),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl:
                                  'https://image.freepik.com/free-photo/beef-burger-with-chopped-onions-tomatoes-inside-bread-bun-with-french-fries-stone-platter_114579-1865.jpg',
                            ),
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
                    child: Text(
                      'Description',
                      style: textStyle.middleTSBasic.copyWith(
                          color: globalColor.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description jhsdhd hdhghd duhhjdjd Description jhsdhd hdhghd duhhjdjd Description jhsdhd hdhghd duhhjdjd',
                      style: textStyle.middleTSBasic.copyWith(
                          color: globalColor.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                      textAlign: TextAlign.left,
                    ),
                  ),

                ],
              ),
            )]
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
        Text(
          '100 \$',
          style: textStyle.middleTSBasic.copyWith(
              color: globalColor.black,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp),
        ),
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
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.r)),
                            color: Colors.white),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.freepik.com/free-photo/beef-burger-with-chopped-onions-tomatoes-inside-bread-bun-with-french-fries-stone-platter_114579-1865.jpg',
                        ),
                      );
                    }),
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
