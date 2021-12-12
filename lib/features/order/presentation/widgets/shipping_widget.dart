import 'package:ajb1/features/order/presentation/widgets/shipped_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/res/screen/vertical_padding.dart';

class ShippedWidget extends StatefulWidget {
  const ShippedWidget({Key? key}) : super(key: key);

  @override
  _ShippedWidgetState createState() => _ShippedWidgetState();
}

class _ShippedWidgetState extends State<ShippedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('الشحنة رقم واحد'),
                    Spacer(),
                    Icon(Icons.more_horiz)
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text('تم الشحن في تاريخ 20'),
                SizedBox(
                  height: 15.h,
                ),
                _buildStepsWidget(),
                SizedBox(
                  height: 5.h,
                ),
                Divider(height: 1.h, color: Colors.grey),
              ],
            ),
          ),
          ListView.separated(
              padding: const EdgeInsets.all(8),
              separatorBuilder: (context, index) =>
                  Divider(height: 1.h, color: Colors.grey),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return ShippedItemWidget();
              }),
        ],
      ),
    ));
  }

  _buildStepsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              ),
              VerticalPadding(),
              Text(
                'تم الطلب',
                style: TextStyle(fontSize: 8.sp),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 2,
            width: 40.w,
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: Colors.green)),
              ),
              VerticalPadding(),
              Text(
                'تم الاستلام',
                style: TextStyle(fontSize: 8.sp),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 2,
            width: 40,
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green)),
              VerticalPadding(),
              Text(
                'تم الشحن',
                style: TextStyle(fontSize: 8.sp),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 2,
            width: 40,
            color: Colors.green,
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green)),
              VerticalPadding(),
              Text(
                'تم الاستلام',
                style: TextStyle(fontSize: 8.sp),
              )
            ],
          ),
        ),
      ],
    );
  }
}
