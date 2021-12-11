import 'package:ajb1/core/ui/list/build_list_category.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';

import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/utils.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/ui/widget/text/normal_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/global_color.dart';

class SectionPage extends StatefulWidget {
  static const routeName = '/section/pages/SectionPage';

  @override
  _SectionPageState createState() => _SectionPageState();
}

class _SectionPageState extends State<SectionPage> {
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
        Translations.of(context).translate('section'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double widthC = globalSize.setWidthPercentage(100, context);
    double heightC = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        body: Container(
            child: BuildListCategoryWidget(
          params: {},
          cancelToken: _cancelToken,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: globalSize.setWidthPercentage(40, context) /
                globalSize.setWidthPercentage(40, context),
          ),
        )));
  }

  // _buildGrid(){
  //   return GridView.builder(
  //       padding: const EdgeInsets.only(left: EdgeMargin.small,right:EdgeMargin.small),
  //       itemCount: _itemsCategory.length,
  //       shrinkWrap: true,
  //       gridDelegate:
  //       SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         crossAxisSpacing: 4,
  //         mainAxisSpacing: 4,
  //         childAspectRatio:
  //         globalSize.setWidthPercentage(40, context) /
  //             globalSize.setWidthPercentage(40, context),
  //       ),
  //       itemBuilder: (context, index) {
  //         return ItemSection(
  //           categoryModel: _itemsCategory[index],
  //           height: globalSize.setWidthPercentage(40, context),
  //           width: globalSize.setWidthPercentage(40, context),
  //         );
  //       });
  // }
  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
