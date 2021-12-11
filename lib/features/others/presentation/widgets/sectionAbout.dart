import 'package:flutter/material.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionAbout extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SectionAbout(
      {required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    double widthC = globalSize.setWidthPercentage(100, context);
    return Container(
      width: widthC,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(
                  top: EdgeMargin.small,
                  left: EdgeMargin.min,
                  right: EdgeMargin.min,
                  bottom: EdgeMargin.subSubMin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: ScreenUtil().setHeight(15),
                    color: globalColor.primaryColor,
                  ),
                  SizedBox(
                    width: widthC * .02,
                  ),
                  Text(
                    title,
                    style: textStyle.middleTSBasic
                        .copyWith(color: globalColor.primaryColor),
                  ),
                ],
              )),
          Container(
            color: globalColor.backgroundGreyLight,
            width: widthC,
            child: Container(
                margin: const EdgeInsets.only(
                    top: EdgeMargin.small,
                    left: EdgeMargin.small,
                    right: EdgeMargin.small,
                    bottom: EdgeMargin.min),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          description,
                          style: textStyle.smallTSBasic
                              .copyWith(color: globalColor.black),
                        ),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
