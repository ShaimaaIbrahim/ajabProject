import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippedItemWidget extends StatefulWidget {
  const ShippedItemWidget({Key? key}) : super(key: key);

  @override
  _ShippedItemWidgetState createState() => _ShippedItemWidgetState();
}

class _ShippedItemWidgetState extends State<ShippedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.all(10.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Image.network(
                      'https://image.freepik.com/free-photo/clock-without-hands_1112-638.jpg',
                      width: 50.w,
                      height: 100.h)),
              SizedBox(width: 15.w),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Text('FITMINIT'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('SMART WATCH'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('A R S 478784'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 1, right: 1),
          //   child: Container(
          //     height: 1.h,
          //     color: Colors.grey[400],
          //   ),
          // )
        ],
      ),
    ));
  }
}
