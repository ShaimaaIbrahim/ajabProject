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
      child: Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Image.network(
                  'https://image.freepik.com/free-photo/clock-without-hands_1112-638.jpg',
                  width: 50.w,
                  height: 100.h)),
          SizedBox(width: 30.w),
          Expanded(
              flex: 3,
              child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
    ));
  }
}
