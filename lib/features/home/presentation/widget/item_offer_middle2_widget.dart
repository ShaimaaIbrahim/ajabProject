import 'package:ajb1/core/entities/offer_item_entity.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ajb1/features/product/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
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

class ItemOfferMiddle2Widget extends StatelessWidget {
  final OfferItemEntity offerItem;
  final double width;
  final double height;
  const ItemOfferMiddle2Widget(
      {required this.offerItem, required this.width, required this.height});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (offerItem.is_glasses != null && offerItem.is_glasses!)
          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                      id: offerItem.productId,
                      name: offerItem.name,
                      category_id: 0,
                      image: '',
                      is_new: false,
                      isReview: false,
                      isFavorite: false,
                      quantity: 0,
                      review_count: 0,
                      discount_price: 0,
                      discount_type: '',
                      description: '',
                      price: 0,
                      rate: '',
                      product_as_same: [])));
        else
          Get.Get.toNamed(LensesDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                      id: offerItem.productId,
                      name: offerItem.name,
                      category_id: 0,
                      image: '',
                      is_new: false,
                      isReview: false,
                      isFavorite: false,
                      quantity: 0,
                      review_count: 0,
                      discount_price: 0,
                      discount_type: '',
                      description: '',
                      price: 0,
                      rate: '',
                      product_as_same: [])));
      },
      child: Container(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(EdgeMargin.small, EdgeMargin.sub,
            EdgeMargin.small, EdgeMargin.verySub),
        child: Container(
          width: width,
          height: 90.h,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(width * .04)),
            child: Stack(
              children: [
                Container(
                  width: width,
                  height: 90.h,
                  child: ImageCacheWidget(
                    imageUrl: offerItem.image ?? '',
                    imageWidth: width,
                    imageHeight: 90.h,
                    boxFit: BoxFit.cover,
                  ),
                ),
                // Align(
                //   alignment: AlignmentDirectional.centerEnd,
                //   child: Container(
                //     width: 174.86.w,
                //     child: Stack(
                //       children: [
                //         Diagonal(
                //           clipHeight: 90.0,
                //           axis: Axis.vertical,
                //           position: DiagonalPosition.TOP_RIGHT,
                //           child: Container(
                //               width: 174.86.w,
                //               height: 90.h,
                //               color: globalColor.primaryColor,
                //               child: Container()),
                //         ),
                //         Container(
                //           width: 174.86.w,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             children: [
                //               Padding(
                //                 padding: const EdgeInsets.only(
                //                     left: EdgeMargin.small,
                //                     right: EdgeMargin.small,
                //                     top: EdgeMargin.verySub),
                //                 child: Text(
                //                   Translations.of(context).translate('discount'),
                //                   style: textStyle.lagerTSBasic
                //                       .copyWith(color: globalColor.white),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         Container(
                //           width: 174.86.w,
                //           child: Container(
                //             alignment: AlignmentDirectional.centerEnd,
                //             padding: const EdgeInsets.fromLTRB(
                //                 EdgeMargin.subMin,
                //                 EdgeMargin.small,
                //                 EdgeMargin.subMin,
                //                 EdgeMargin.sub),
                //             child: Container(
                //               width: 50.w,
                //               height: 50.w,
                //               decoration: BoxDecoration(
                //                   color: globalColor.goldColor,
                //                   border: Border.all(
                //                       color: globalColor.white, width: 0.5),
                //                   shape: BoxShape.circle),
                //               child: FittedBox(
                //                 child: Padding(
                //                   padding: const EdgeInsets.all(EdgeMargin.sub),
                //                   child: Column(
                //                     children: [
                //
                //                       Text('${offerItem.discountPrice ?? ''}',
                //                           style: textStyle.lagerTSBasic.copyWith(
                //                               fontWeight: FontWeight.bold,
                //                               color: globalColor.primaryColor)),
                //
                //                       Text(
                //                           offerItem.discountTypeInt!=null && offerItem.discountTypeInt ==1 ?
                //                           Translations.of(context)
                //                               .translate('rail'): '%',
                //                           style: textStyle.subMinTSBasic.copyWith(
                //                               height: .6,
                //                               color: globalColor.white)),
                //                     ],
                //                   ),
                //                 ),
                //               ),
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
        ),
      )),
    );
  }
}
