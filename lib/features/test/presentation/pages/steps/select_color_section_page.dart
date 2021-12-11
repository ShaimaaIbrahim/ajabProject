import 'package:ajb1/core/bloc/application_bloc.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/widget/button/rounded_button.dart';
import 'package:ajb1/features/test/presentation/widgets/select_color_select_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class SelectColorSectionPage extends StatefulWidget {
  // static const routeName =
  //     '/features/add_car/presentation/pages/AddNewCarStep1';

  final PageController controller;
  final double? height;
  final double? width;
  final Function(int, String, int) onSelect;
  final Function() doneAction;

  const SelectColorSectionPage({
    required this.controller,
    required this.width,
    required this.height,
    required this.onSelect,
    required this.doneAction,
  });

  @override
  _SelectColorSectionPageState createState() => _SelectColorSectionPageState();
}

class _SelectColorSectionPageState extends State<SelectColorSectionPage> {
  bool? _isSelected;
  int? _styleSelected;
  List<ExtraGlassesItemEntity>? colorList;
  @override
  void initState() {
    super.initState();
    _isSelected = false;
    colorList =
        BlocProvider.of<ApplicationBloc>(context).state.extraGlasses?.colors ??
            [];
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
                    Translations.of(context).translate('select_color'),
                    style: textStyle.middleTSBasic.copyWith(
                        color: globalColor.black, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: SelectColorSelectWidget(
                    onSelected: _onSelectedStyle,
                    items: colorList!,
                    width: widthC,
                    height: heightC - 83.h,
                  ),
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
                          widget.onSelect(6, 'select_color', _styleSelected!);
                          // widget.controller.nextPage(
                          //     duration: kTabScrollDuration, curve: Curves.ease);
                          if (widget.doneAction != null) {
                            widget.doneAction();
                          }
                        }
                      },
                borderRadius: 8.w,
                child: Container(
                  child: Center(
                    child: Text(
                      Translations.of(context).translate('search'),
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
