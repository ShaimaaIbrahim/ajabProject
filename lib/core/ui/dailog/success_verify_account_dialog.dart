import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/features/user_management/presentation/pages/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' as Get;
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/icon_size.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessVerifyAccountDialog extends StatefulWidget {
  // final String title;
  // final String confirmMessage;
  // final String messageYes;
  // final Function() actionYes;
  // final Function() actionNo;
  // final double heightC;
  // const LoginFirstDialog({
  //   this.title,
  //   this.confirmMessage,
  //   this.heightC = 150,
  //   this.messageYes,
  //   this.actionYes,
  //   this.actionNo,
  // });

  @override
  State<StatefulWidget> createState() => _SuccessVerifyAccountDialogState();
}

class _SuccessVerifyAccountDialogState extends State<SuccessVerifyAccountDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 750));
//    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: const EdgeInsets.all(EdgeMargin.big),
              padding: const EdgeInsets.all(EdgeMargin.small),
              decoration: ShapeDecoration(
                  color: globalColor.white,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10)))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 98,
                    height: 98,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0XFFEFF1F3)),
                    child: Center(
                      child: SvgPicture.asset(AppAssets.check_add_to_cart_svg),
                    ),
                  ),
                  Text(
                    '${Translations.of(context).translate('success_active_account')}',
                    style: textStyle.bigTSBasic.copyWith(
                        color: globalColor.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: EdgeMargin.subMin,
                        right: EdgeMargin.subMin,
                        top: EdgeMargin.subMin),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      '${Translations.of(context).translate('msg_success_active_account')}',
                      style: textStyle.minTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  VerticalPadding(
                    percentage: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      HorizontalPadding(
                        percentage: 2,
                      ),
                      Expanded(
                        child: Container(
                          child: ButtonTheme(
                              height: 50.h,
                              minWidth: 130.w,
                              child: RaisedButton(
                                  color: globalColor.primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: Text(
                                    '${Translations.of(context).translate('login')}',
                                    textAlign: TextAlign.center,
                                    style: textStyle.minTSBasic
                                        .copyWith(color: globalColor.white),
                                  ),
                                  onPressed: () {
                                    Get.Get.offAllNamed(SignInPage.routeName);
                                  })),
                        ),
                      ),
                      HorizontalPadding(
                        percentage: 2,
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
