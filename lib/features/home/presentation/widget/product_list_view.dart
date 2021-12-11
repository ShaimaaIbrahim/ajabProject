import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:ajb1/core/res/text_size.dart';
import 'package:ajb1/core/res/utils.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/features/home/domain/model/product_model.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as Get;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ajb1/core/bloc/application_bloc.dart';
import 'package:ajb1/core/entities/extra_glasses_item_entity.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/shared_preference_utils/shared_preferences.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/ui/widget/image/image_caching.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ajb1/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ajb1/core/entities/extra_glasses_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:ajb1/features/profile/domin/repositories/profile_repository.dart';
import 'package:ajb1/features/profile/domin/usecases/get_user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:get/get.dart' as Get;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductItemWidget extends StatefulWidget {
  final OffersAndDiscount product;
  final double? width;
  final double? height;

  // final double height;
  const CustomProductItemWidget(
      {required this.product, required this.width, required this.height});

  @override
  _CustomProductItemWidgetState createState() =>
      _CustomProductItemWidgetState();
}

class _CustomProductItemWidgetState extends State<CustomProductItemWidget> {
  @override
  Widget build(BuildContext context) {
    double width = widget.width ?? globalSize.setWidthPercentage(43, context);
    double height =
        widget.height ?? globalSize.setHeightPercentage(60, context);
    return Container(
      // width: width,
      height: height,
      // color: globalColor.red,
      padding: EdgeInsets.only(
          left: utils.getLang() == 'ar' ? 0.0 : EdgeMargin.verySub,
          right: utils.getLang() == 'ar' ? EdgeMargin.verySub : 0.0),
      child: InkWell(
        onTap: () {
          print('click');
          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments1(product: widget.product));
          // else
          //   Get.Get.toNamed(LensesDetailsPage.routeName,preventDuplicates: false,arguments: ProductDetailsArguments(product: widget.product));
        },
        child: Card(
          elevation: 6,
          shadowColor: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0.w))),
          child: Container(
              decoration: BoxDecoration(
                color: globalColor.white,
                borderRadius: BorderRadius.circular(12.0.w),
              ),
              //   padding: const EdgeInsets.all(1.0),
              width: width,
              height: height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(EdgeMargin.verySub),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0.w)),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ImageCacheWidget(
                                    imageUrl:
                                        'https://image.freepik.com/free-photo/beef-burger-with-chopped-onions-tomatoes-inside-bread-bun-with-french-fries-stone-platter_114579-1865.jpg',
                                    boxFit: BoxFit.fill,
                                    imageHeight: 100,
                                    imageWidth: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(EdgeMargin.sub),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Container(
                                    width: width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: RichText(
                                            overflow: TextOverflow.ellipsis,
                                            strutStyle: StrutStyle(
                                                fontSize: textSize.middle),
                                            maxLines: 2,
                                            text: TextSpan(
                                                style: textStyle.middleTSBasic
                                                    .copyWith(
                                                  color: globalColor.black,
                                                ),
                                                text: widget.product.name),
                                          ),
                                        ),

                                        _buildPriceWidget(
                                            width: width,
                                            discountPrice: '0',
                                            price: widget.product.price
                                                .toDouble()),
                                        /*
                                            discountPrice: widget
                                                .product.price_discount
                                                .toString()),*/
                                        VerticalPadding(
                                          percentage: 0.5,
                                        ),

                                        // Container(
                                        //   child: FittedBox(
                                        //     child: Row(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.center,
                                        //       children: [
                                        //         Container(
                                        //           width: 12.w,
                                        //           height: 12.w,
                                        //           decoration: BoxDecoration(
                                        //               color: globalColor.goldColor,
                                        //               shape: BoxShape.circle,
                                        //               border: Border.all(
                                        //                   width: 1.0,
                                        //                   color: globalColor
                                        //                       .primaryColor)),
                                        //           child: Icon(
                                        //             MaterialIcons.check,
                                        //             color: globalColor.black,
                                        //             size: 10.w,
                                        //           ),
                                        //         ),
                                        //         Container(
                                        //           padding: const EdgeInsets.only(
                                        //               left: EdgeMargin.sub,
                                        //               right: EdgeMargin.sub),
                                        //           child: RichText(
                                        //             text: TextSpan(
                                        //               text: appConfig
                                        //                       .notNullOrEmpty(widget
                                        //                           .product
                                        //                           .colorInfo
                                        //                           ?.length
                                        //                           .toString())
                                        //                   ? widget
                                        //                       .product
                                        //                       .colorInfo
                                        //                       ?.length
                                        //                       .toString()
                                        //                   : '-',
                                        //               style: textStyle.minTSBasic
                                        //                   .copyWith(
                                        //                       fontWeight:
                                        //                           FontWeight.bold,
                                        //                       color: globalColor
                                        //                           .primaryColor),
                                        //               children: <TextSpan>[
                                        //                 new TextSpan(
                                        //                     text:
                                        //                         ' ${Translations.of(context).translate('colors_available')}',
                                        //                     style: textStyle
                                        //                         .minTSBasic
                                        //                         .copyWith(
                                        //                             color:
                                        //                                 globalColor
                                        //                                     .grey)),
                                        //               ],
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  // HorizontalPadding(
                                  //   percentage: 1.0,
                                  // ),
                                  // _buildPriceWidget(
                                  //     width: width * 0.35,
                                  //     price: widget.product.price,
                                  //     discountPrice:
                                  //         widget.product.priceAfterDiscount)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     Expanded(
                  //       flex:7,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         crossAxisAlignment: CrossAxisAlignment.end,
                  //         children: [
                  //           widget.product.type!=1 ?
                  //           Container(
                  //             decoration: BoxDecoration(
                  //               color: globalColor.white,
                  //               borderRadius: BorderRadius.circular(12.0.w),
                  //             ),
                  //             padding: const EdgeInsets.fromLTRB(EdgeMargin.verySub, EdgeMargin.verySub, EdgeMargin.verySub, EdgeMargin.verySub),
                  //             constraints: BoxConstraints(maxWidth: width*.5),
                  //             child: Text('عدسات طبية',style: textStyle.minTSBasic.copyWith(
                  //               color: globalColor.black
                  //             ),),
                  //           ) : Container(),
                  //         ],
                  //       ),
                  //     ),
                  //     Expanded(flex:6,child: Container(),)
                  //   ],
                  // )
                ],
              )),
        ),
      ),
    );
  }

  _buildPriceWidget(
      {required double price,
      required String discountPrice,
      required double width}) {
    return Container(
      width: width,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          discountPrice != null && discountPrice != "0.0"
              ? Container(
                  child: RichText(
                  text: TextSpan(
                    text: '${discountPrice.toString()}',
                    style: textStyle.smallTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        color: globalColor.grey),
                    children: <TextSpan>[
                      new TextSpan(
                          text:
                              ' ${Translations.of(context).translate('rail')}',
                          style: textStyle.subMinTSBasic
                              .copyWith(color: globalColor.grey)),
                    ],
                  ),
                ))
              : Container(
                  child: RichText(
                  text: TextSpan(
                    text: price.toString(),
                    style: textStyle.smallTSBasic.copyWith(
                        fontWeight: FontWeight.bold,
                        color: globalColor.primaryColor),
                    children: <TextSpan>[
                      new TextSpan(
                          text:
                              ' ${Translations.of(context).translate('rail')}',
                          style: textStyle.subMinTSBasic
                              .copyWith(color: globalColor.black)),
                    ],
                  ),
                )),

          SizedBox(
            width: 10,
          ),
          // discountPrice != null && discountPrice.isNotEmpty
          //     ?
          Container(
              child: FittedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$price",
                  style: textStyle.smallTSBasic.copyWith(
                      fontWeight: FontWeight.bold,
                      color: globalColor.primaryColor),
                ),
                Text(' ${Translations.of(context).translate('rail')}',
                    style: textStyle.smallTSBasic
                        .copyWith(color: globalColor.primaryColor)),
                // RichText(
                //   text: TextSpan(
                //     text: discountPrice ?? '',
                //     style: textStyle.smallTSBasic.copyWith(
                //         fontWeight: FontWeight.bold,
                //         color: globalColor.primaryColor),
                //     children: <TextSpan>[
                //       new TextSpan(
                //           text:
                //               ' ${Translations.of(context).translate('rail')}',
                //           style: textStyle.subMinTSBasic
                //               .copyWith(color: globalColor.primaryColor)),
                //     ],
                //   ),
                // ),
              ],
            ),
          ))
          // : SizedBox.shrink(),
        ],
      ),
    );
  }
}
