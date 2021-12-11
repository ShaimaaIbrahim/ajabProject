import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/hex_color.dart';
import 'package:ajb1/features/product/domin/entities/general_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import '../args/product_list_args.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemColorProductDetails extends StatefulWidget {
  final GeneralItemEntity item;
  final Function(GeneralItemEntity, bool) onSelect;
  final bool isSelected;
  const ItemColorProductDetails(
      {required this.item, required this.onSelect, required this.isSelected});
  @override
  _ItemColorFilterState createState() => _ItemColorFilterState();
}

class _ItemColorFilterState extends State<ItemColorProductDetails> {
  // bool _isSelect =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _isSelect = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              // _isSelect= !_isSelect;
              if (widget.onSelect != null) {
                widget.onSelect(widget.item, true);
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
          width: 55.w,
          margin: const EdgeInsets.only(
              left: EdgeMargin.verySub,
              right: EdgeMargin.verySub,
              bottom: EdgeMargin.verySub),
          child: Padding(
            padding: const EdgeInsets.all(EdgeMargin.sub),
            child: Stack(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   //  shape: BoxShape.circle,
                  //     color: HexColor(widget.item.value)),
                  child: SvgPicture.asset(AppAssets.glasses_svg,
                      color: HexColor(widget.item.value)),
                ),
                widget.isSelected
                    ? Container(
                        decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
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
