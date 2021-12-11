import 'package:ajb1/core/entities/extra_glasses_item_entity.dart';
import 'package:ajb1/core/res/hex_color.dart';
import 'package:flutter/material.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemColorFilter extends StatefulWidget {
  final ExtraGlassesItemEntity? item;
  final Function(ExtraGlassesItemEntity, bool)? onSelect;
  const ItemColorFilter({this.item, this.onSelect});
  @override
  _ItemColorFilterState createState() => _ItemColorFilterState();
}

class _ItemColorFilterState extends State<ItemColorFilter> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              _isSelect = !_isSelect;
              if (widget.onSelect != null) {
                widget.onSelect!(widget.item!, _isSelect);
              }
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: globalColor.white,
            borderRadius: BorderRadius.all(Radius.circular(10.w)),
            border: Border.all(
                color: globalColor.grey.withOpacity(0.3), width: 0.5),
          ),
          height: 35.h,
          width: 35.w,
          margin: const EdgeInsets.only(
              left: EdgeMargin.verySub,
              right: EdgeMargin.verySub,
              bottom: EdgeMargin.verySub),
          child: Padding(
            padding: const EdgeInsets.all(EdgeMargin.sub),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: HexColor(widget.item!.value!)),
                ),
                _isSelect
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: globalColor.black.withOpacity(0.3),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 15,
                            color: globalColor.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
