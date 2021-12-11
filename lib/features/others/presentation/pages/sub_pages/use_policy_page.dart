import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ajb1/core/ui/widget/network/network_widget.dart';
import 'package:ajb1/features/others/domain/entity/privacy_result.dart';
import 'package:ajb1/features/others/domain/usecases/get_privacy.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

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


import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:get/get.dart' as Get;
import '../../../../../main.dart';

class UsePolicyPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/UsePolicyPage';

  @override
  _UsePolicyPageState createState() => _UsePolicyPageState();
}

class _UsePolicyPageState extends State<UsePolicyPage> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  @override
  Widget build(BuildContext context) {
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('use_policy'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: NetworkWidget<PrivacyAppResult>(
          loadingWidgetBuilder: (BuildContext context) {
            return Container(
              width: width,
              height: height,
              child: BaseShimmerWidget(
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          },
          fetcher: () {
            return GetPrivacyApp(locator<CoreRepository>())(
              GetPrivacyAppParams(
                isPrivacyApp: true,
                cancelToken: _cancelToken,
              ),
            );
          },
          builder: (BuildContext context, aboutAppResult) {
            return Container(
                height: height,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        VerticalPadding(
                          percentage: 2.0,
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              left: EdgeMargin.min, right: EdgeMargin.min),
                          child: _buildTextWidget(
                              width: width,
                              context: context,
                              title: aboutAppResult.details),
                        ),
                        VerticalPadding(
                          percentage: 4.0,
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }

  _buildTextWidget(
      {required BuildContext context,
      required double width,
      required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: globalColor.white,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
        // border:
        // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
      ),
      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      width: width,

      child: Padding(
        padding: const EdgeInsets.all(EdgeMargin.min),
        child: Text(
          title,
          style: textStyle.smallTSBasic
              .copyWith(color: globalColor.black, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
