import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/widget/button/rounded_button.dart';
import 'package:ajb1/features/test/presentation/widgets/start_testing_select_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/entities/extra_glasses_item_entity.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/hex_color.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class StartTestingSectionPage extends StatefulWidget {
  // static const routeName =
  //     '/features/add_car/presentation/pages/AddNewCarStep1';

  final PageController controller;
  final double? height;
  final double? width;
  final Function(int, String, int) onSelect;

  const StartTestingSectionPage({
    required this.controller,
    required this.width,
    required this.height,
    required this.onSelect,
  });

  @override
  _StartTestingSectionPageState createState() =>
      _StartTestingSectionPageState();
}

class _StartTestingSectionPageState extends State<StartTestingSectionPage> {
  bool? _isSelected;
  int? _styleSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    double widthC = widget.width ?? globalSize.setWidthPercentage(100, context);
    double heightC =
        widget.height ?? globalSize.setHeightPercentage(100, context);

    return Scaffold(
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: Container(
            width: widthC,
            height: heightC,
            // color: globalColor.white,
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.centerStart,
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.min, right: EdgeMargin.min),
                  child: Text(
                    Translations.of(context)
                        .translate('select_the_type_of_glasses'),
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          StartTestingSelectWidget(
                            onSelected: _onSelectedStyle,
                            items: [
                              ExtraGlassesItemEntity(
                                  id: 1,
                                  image: AppAssets.sun_glasses_test,
                                  name: Translations.of(context)
                                      .translate('sunglasses'),
                                  value: '1'),
                              ExtraGlassesItemEntity(
                                  id: 0,
                                  image: AppAssets.medical_glasses_test,
                                  name: Translations.of(context)
                                      .translate('Goggles'),
                                  value: '0'),
                            ],
                            width: widthC,
                            height: heightC - 83.h,
                          ),
                        ],
                      )),
                ),
                _buildButtonsWidget(
                    height: heightC, context: context, widthC: widthC),
              ],
            )));
  }

  _buildButtonsWidget(
      {required BuildContext context,
      required double widthC,
      required double height}) {
    return Container(
      height: 80.h,
      width: widthC,
      color: globalColor.white,
      child: Center(
        child: Container(
          height: 50.h,
          padding: const EdgeInsets.only(
              left: EdgeMargin.min, right: EdgeMargin.min),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  child: RoundedButton(
                height: 50.h,
                width: widthC * .35,
                color: globalColor.primaryColor,
                onPressed: _styleSelected == null
                    ? () {}
                    : () {
                        if (widget.onSelect != null) {
                          widget.onSelect(1, 'style_glasses', _styleSelected!);
                          widget.controller.nextPage(
                              duration: kTabScrollDuration, curve: Curves.ease);
                        }
                      },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('continue'),
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.white),
                    ),
                  ),
                ),
              )),
              HorizontalPadding(
                percentage: 4.0,
              ),
              Container(
                  child: RoundedButton(
                height: 50.h,
                width: widthC * .35,
                color: globalColor.backgroundLightPrim,
                onPressed: () {},
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('cancel'),
                      style: textStyle.smallTSBasic
                          .copyWith(color: globalColor.black),
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  _onSelectedStyle(int selected) {
    if (mounted)
      setState(() {
        _styleSelected = selected;
      });
    print('style selected is ${_styleSelected.toString()}');
  }
}
