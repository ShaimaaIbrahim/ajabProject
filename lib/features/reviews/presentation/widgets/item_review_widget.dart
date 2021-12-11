import 'dart:ui';

import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/ui/widget/button/rounded_button.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/pages/product_details_page.dart';
import 'package:ajb1/features/reviews/presentation/pages/add_reviews_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
class ItemReviewWidget extends StatelessWidget {
  final double width;
  final ProductEntity review;
  const ItemReviewWidget({required this.width, required this.review});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  if (review.isGlasses != null && review.isGlasses!)
        Get.Get.toNamed(ProductDetailsPage.routeName,
            preventDuplicates: false,
            arguments: ProductDetailsArguments(product: review));
        //  else
        //     Get.Get.toNamed(LensesDetailsPage.routeName,
        //         preventDuplicates: false,
        //         arguments: ProductDetailsArguments(product: review));
      },
      child: Container(
        // padding: const EdgeInsets.only(
        //     left: EdgeMargin.min, right: EdgeMargin.min),
        child: Card(
            color: globalColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
              child: Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min,
                          right: EdgeMargin.min,
                          bottom: EdgeMargin.verySub,
                          top: EdgeMargin.min),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: 32,
                                  height: 126.h,
                                  child: ImageCacheWidget(
                                    imageUrl: review.image ?? '',
                                    imageWidth: 10.w,
                                    imageHeight: 126.h,
                                    imageBorderRadius: 12.w,
                                  ),
                                ),
                              ),
                              HorizontalPadding(
                                percentage: 2.5,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 126.h,
                                  decoration: BoxDecoration(
                                      color: globalColor.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0.w)),
                                      border: Border.all(
                                          color:
                                              globalColor.grey.withOpacity(0.3),
                                          width: 0.5)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(EdgeMargin.sub),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          review.rate.toString(),
                                          style: textStyle.bigTSBasic.copyWith(
                                              color: globalColor.goldColor,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          '${Translations.of(context).translate('producer_reviews')}',
                                          style: textStyle.minTSBasic.copyWith(
                                              color: globalColor.black,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Text(
                                          '${Translations.of(context).translate('average')} ${review.rate ?? ''} ${Translations.of(context).translate('reviews')}',
                                          style: textStyle.minTSBasic.copyWith(
                                              color: globalColor.black,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Text(
                                            '${review.name ?? ''}',
                                            style:
                                                textStyle.smallTSBasic.copyWith(
                                              color: globalColor.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 15.w,
                                                height: 15.w,
                                                decoration: BoxDecoration(
                                                    color:
                                                        globalColor.goldColor,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        width: 1.0,
                                                        color: globalColor
                                                            .primaryColor)),
                                                child: Icon(
                                                  Icons.check,
                                                  color: globalColor.black,
                                                  size: 10.w,
                                                ),
                                              ),
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: EdgeMargin.sub,
                                                          right:
                                                              EdgeMargin.sub),
                                                  child: Text(
                                                    '${Translations.of(context).translate('free_lenses')}',
                                                    style: textStyle
                                                        .subMinTSBasic
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: globalColor
                                                                .grey),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                      alignment: AlignmentDirectional.centerEnd,
                                      padding: const EdgeInsets.fromLTRB(
                                          EdgeMargin.verySub,
                                          EdgeMargin.sub,
                                          EdgeMargin.verySub,
                                          EdgeMargin.sub),
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                color: globalColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        12.0.w),
                                              ),
                                              constraints: BoxConstraints(
                                                  minWidth: width * .15),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: EdgeMargin.verySub,
                                                    right: EdgeMargin.verySub),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    // SizedBox(
                                                    //   width: 2,
                                                    // ),
                                                    SvgPicture.asset(
                                                      AppAssets.newww,
                                                      width: 12,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      '${Translations.of(context).translate('new')}',
                                                      style: textStyle
                                                          .smallTSBasic
                                                          .copyWith(
                                                              color: globalColor
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: globalColor.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              12.w)),
                                                  border: Border.all(
                                                      color: globalColor.grey
                                                          .withOpacity(0.3),
                                                      width: 0.5)),
                                              constraints: BoxConstraints(
                                                  minWidth: width * .1),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    SvgPicture.asset(
                                                      AppAssets.user,
                                                      width: 16,
                                                    ),
                                                    SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      '',
                                                      style: textStyle
                                                          .minTSBasic
                                                          .copyWith(
                                                        color:
                                                            globalColor.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            review.discount_type != null
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            globalColor.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12.w)),
                                                        border: Border.all(
                                                            color: globalColor
                                                                .grey
                                                                .withOpacity(
                                                                    0.3),
                                                            width: 0.5)),
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        EdgeMargin.subSubMin,
                                                        EdgeMargin.verySub,
                                                        EdgeMargin.subSubMin,
                                                        EdgeMargin.verySub),
                                                    child:
                                                        review.discount_type ==
                                                                1
                                                            ? Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                    '${review.discount_price ?? '-'} ${Translations.of(context).translate('rail')}',
                                                                    style: textStyle
                                                                        .smallTSBasic
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: globalColor.primaryColor),
                                                                  ),
                                                                  Text(
                                                                      ' ${Translations.of(context).translate('discount')}',
                                                                      style: textStyle
                                                                          .minTSBasic
                                                                          .copyWith(
                                                                              color: globalColor.black)),
                                                                ],
                                                              )
                                                            : Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    '${review.discount_price ?? '-'} %',
                                                                    style: textStyle
                                                                        .smallTSBasic
                                                                        .copyWith(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: globalColor.primaryColor),
                                                                  ),
                                                                  Text(
                                                                      ' ${Translations.of(context).translate('discount')}',
                                                                      style: textStyle
                                                                          .minTSBasic
                                                                          .copyWith(
                                                                              color: globalColor.black)),
                                                                ],
                                                              ),
                                                  )
                                                : Container(),
                                            // Container(
                                            //   height:25,
                                            //   decoration: BoxDecoration(
                                            //       color: globalColor.white,
                                            //       borderRadius:
                                            //       BorderRadius.all(Radius.circular(12.w)),
                                            //       border: Border.all(
                                            //           color: globalColor.grey.withOpacity(0.3),
                                            //           width: 0.5)),
                                            //   padding: const EdgeInsets.fromLTRB(
                                            //       EdgeMargin.subSubMin,
                                            //       EdgeMargin.verySub,
                                            //       EdgeMargin.subSubMin,
                                            //       EdgeMargin.verySub),
                                            //   child: Row(
                                            //     mainAxisSize: MainAxisSize.min,
                                            //     crossAxisAlignment:
                                            //     CrossAxisAlignment.center,
                                            //     children: [
                                            //       Text(
                                            //         '${ '-'} %' ?? '',
                                            //         style: textStyle.smallTSBasic
                                            //             .copyWith(
                                            //             fontWeight: FontWeight.bold,
                                            //             color:
                                            //             globalColor.primaryColor),
                                            //       ),
                                            //       Text(
                                            //           ' ${Translations.of(context).translate('discount')}',
                                            //           style: textStyle.minTSBasic
                                            //               .copyWith(
                                            //               color: globalColor.black)),
                                            //     ],
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      )))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: globalColor.grey.withOpacity(0.3),
                      height: 2.0,
                    ),
                    review.isReview != null && review.isReview!
                        ? Container(
                            color: globalColor.scaffoldBackGroundGreyColor,
                            width: width,
                            padding: const EdgeInsets.only(
                                left: EdgeMargin.min,
                                right: EdgeMargin.min,
                                bottom: EdgeMargin.min,
                                top: EdgeMargin.min),
                            child: Text(
                              '',
                              // review.productReviews != null &&
                              //         review.productReviews!.isNotEmpty
                              //     ? review.productReviews![0].review
                              //     : '',
                              style: textStyle.smallTSBasic
                                  .copyWith(color: globalColor.grey),
                            ),
                          )
                        : Container(
                            width: width,
                            child: RoundedButton(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    Translations.of(context)
                                        .translate('product_review'),
                                    style: textStyle.middleTSBasic
                                        .copyWith(color: globalColor.white),
                                  ),
                                ),
                              ),
                              width: width,
                              onPressed: () {
                                Get.Get.toNamed(AddReviewPage.routeName,
                                    arguments: review);
                              },
                              height: 45.h,
                              color: globalColor.primaryColor,
                              borderRadius: 8.w,
                            ),
                          )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
