import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/features/order/presentation/widgets/shipping_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Orderspage extends StatefulWidget {
  const Orderspage({Key? key}) : super(key: key);

  @override
  _OrderspageState createState() => _OrderspageState();
}

class _OrderspageState extends State<Orderspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(
                    2.0,
                    2.0,
                  ), // shadow direction: bottom right
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translations.of(context).translate('order_number'),
                            style: TextStyle(fontSize: 20.sp),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('NASGS90800970')
                        ],
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_back_ios)
                  ],
                ),
                Container(
                  height: 1.h,
                  color: Colors.grey,
                ),
                ListView.separated(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: 5,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        Divider(height: 1.h, color: Colors.grey),
                    itemBuilder: (BuildContext context, int index) {
                      return ShippedWidget();
                    }),
              ],
            )),
      ),
    )));
  }
}
