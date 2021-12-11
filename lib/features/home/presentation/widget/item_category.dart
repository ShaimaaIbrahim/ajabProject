import 'package:ajb1/core/constants.dart';
import 'package:ajb1/core/entities/category_entity.dart';
import 'package:ajb1/features/product/presentation/args/product_list_args.dart';
import 'package:ajb1/features/product/presentation/pages/product_list_page.dart';
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


class ItemCategory extends StatefulWidget {
  final CategoryEntity category;
  final double width;
  final double height;

  const ItemCategory(
      {required this.category, required this.width, required this.height});

  @override
  _ItemCategoryState createState() => _ItemCategoryState();
}

class _ItemCategoryState extends State<ItemCategory> {
  @override
  Widget build(BuildContext context) {
    final width = widget.width;
    final height = widget.height;
    return InkWell(
      onTap: () {
        Get.Get.toNamed(ProductListPage.routeName,
            arguments: ProductListArguments(
                params: {FILTER_CATEGORY_ID: widget.category.id.toString()}));
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: BoxDecoration(
                    color: globalColor.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(width * .88),
                    border: Border.all(
                        width: 1,
                        color: globalColor.primaryColor.withOpacity(0.4))),
                padding: const EdgeInsets.all(2),
                child: ImageCacheWidget(
                  imageUrl: widget.category.image ?? '',
                  imageHeight: width * .8,
                  imageWidth: width * .8,
                  imageBorderRadius: width * .8,
                  boxFit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              width: width,
              child: Text(
                widget.category.name ?? '',
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 2,
                style: textStyle.minTSBasic.copyWith(color: globalColor.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
