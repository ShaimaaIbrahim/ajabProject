import 'package:ajb1/core/entities/offer_item_entity.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ajb1/features/product/presentation/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/appConfig.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/widget/button/rounded_button.dart';
import 'package:ajb1/core/validators/base_validator.dart';
import 'package:ajb1/core/validators/required_validator.dart';
import 'package:ajb1/features/product/data/models/review_model.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:ajb1/features/product/domin/usecases/add_review.dart';
import 'package:ajb1/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Get;
import '../../../../main.dart';
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

class ItemOfferMiddlePageWidget extends StatelessWidget {
  final OfferItemEntity offerItem;
  final double width;

  const ItemOfferMiddlePageWidget(
      {required this.offerItem, required this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (offerItem.is_glasses != null && offerItem.is_glasses!)
          Get.Get.toNamed(ProductDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                      id: 1,
                      name: offerItem.name,
                      category_id: 1,
                      image: '',
                      is_new: false,
                      isReview: false,
                      isFavorite: false,
                      quantity: 0,
                      review_count: 0,
                      discount_price: 0,
                      discount_type: '',
                      description: '',
                      price: offerItem.discountPrice,
                      rate: '',
                      product_as_same: [])));
        else
          Get.Get.toNamed(LensesDetailsPage.routeName,
              preventDuplicates: false,
              arguments: ProductDetailsArguments(
                  product: ProductEntity(
                      id: 1,
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
                      price: offerItem.discountPrice,
                      rate: '',
                      product_as_same: [])));
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              EdgeMargin.small, 0.0, EdgeMargin.small, 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(width * .04)),
            child: Container(
              color: globalColor.white,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: 189.h,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            child: ImageCacheWidget(
                              imageUrl: offerItem.image ?? '',
                              imageWidth: width,
                              imageHeight: 189.h,
                              boxFit: BoxFit.fill,
                              imageBorderRadius: width * .04,
                            ),
                          ),
                        ),
                        Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: const EdgeInsets.fromLTRB(
                              EdgeMargin.sub, 0.0, EdgeMargin.sub, 0.0),
                          child: Text(
                            offerItem.name ?? '',
                            style: textStyle.smallTSBasic.copyWith(
                                color: globalColor.black,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                  offerItem.discountType != null
                      ? Container(
                          width: width,
                          padding: const EdgeInsets.fromLTRB(
                              EdgeMargin.sub, 0.0, EdgeMargin.sub, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(''),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: globalColor.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.w)),
                                          border: Border.all(
                                              color: globalColor.grey
                                                  .withOpacity(0.3),
                                              width: 0.5)),
                                      padding: const EdgeInsets.fromLTRB(
                                          EdgeMargin.subSubMin,
                                          EdgeMargin.verySub,
                                          EdgeMargin.subSubMin,
                                          EdgeMargin.verySub),
                                      child: offerItem.discountType == 1
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${offerItem.discountPrice ?? '-'} ${Translations.of(context).translate('rail')}',
                                                  style: textStyle.smallTSBasic
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: globalColor
                                                              .primaryColor),
                                                ),
                                                Text(
                                                    ' ${Translations.of(context).translate('discount')}',
                                                    style: textStyle.minTSBasic
                                                        .copyWith(
                                                            color: globalColor
                                                                .black)),
                                              ],
                                            )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${offerItem.discountPrice ?? '-'} %',
                                                  style: textStyle.smallTSBasic
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: globalColor
                                                              .primaryColor),
                                                ),
                                                Text(
                                                    ' ${Translations.of(context).translate('discount')}',
                                                    style: textStyle.minTSBasic
                                                        .copyWith(
                                                            color: globalColor
                                                                .black)),
                                              ],
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                              Text('')
                            ],
                          ),
                        )
                      : Container(),
                  // Align(
                  //   alignment:
                  //   AlignmentDirectional.centerEnd,
                  //   child: Diagonal(
                  //     clipHeight: 45.0,
                  //     axis: Axis.vertical,
                  //     position: DiagonalPosition.TOP_RIGHT,
                  //     child: Container(
                  //       width: width * .3,
                  //       height: 184.h,
                  //       color: globalColor.primaryColor,
                  //       child: Column(
                  //         crossAxisAlignment:
                  //         CrossAxisAlignment.end,
                  //         children: [
                  //
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
