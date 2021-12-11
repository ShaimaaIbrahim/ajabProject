import 'dart:io';

import 'package:ajb1/core/constants.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/ui/items_shimmer/base_shimmer.dart';
import 'package:ajb1/core/ui/widget/network/network_widget.dart';
import 'package:ajb1/features/others/domain/entity/about_app_result.dart';
import 'package:ajb1/features/others/domain/usecases/get_about_app.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ajb1/core/appConfig.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/widget/button/rounded_button.dart';
import 'package:ajb1/core/validators/base_validator.dart';
import 'package:ajb1/core/validators/required_validator.dart';
import 'package:ajb1/features/product/data/models/review_model.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:ajb1/features/product/domin/usecases/add_review.dart';
import 'package:ajb1/features/user_management/presentation/widgets/user_management_text_field_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Get;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ajb1/core/bloc/application_bloc.dart';
import 'package:ajb1/core/entities/extra_glasses_item_entity.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/shared_preference_utils/shared_preferences.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/ui/widget/image/image_caching.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ajb1/core/datasources/local/datasources/cached_extra_glasses_dao.dart';
import 'package:ajb1/core/entities/extra_glasses_entity.dart';
import 'package:ajb1/core/errors/base_error.dart';
import 'package:ajb1/core/params/no_params.dart';
import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:ajb1/features/profile/domin/repositories/profile_repository.dart';
import 'package:ajb1/features/profile/domin/usecases/get_user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:get/get.dart' as Get;
import 'package:url_launcher/url_launcher.dart';

import '../../../../../main.dart';

class AboutOjosPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/AboutOjosPage';

  @override
  _AboutOjosPageState createState() => _AboutOjosPageState();
}

class _AboutOjosPageState extends State<AboutOjosPage> {
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
        Translations.of(context).translate('about_ojos'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
    );

    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        appBar: appBar,
        key: _scaffoldKey,
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        body: NetworkWidget<AboutAppResult>(
          loadingWidgetBuilder: (BuildContext context) {
            return Container(
              width: width,
              height: height,
              child: BaseShimmerWidget(
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          },
          fetcher: () {
            return GetAboutApp(locator<CoreRepository>())(
              GetAboutAppParams(
                cancelToken: _cancelToken,
              ),
            );
          },
          builder: (BuildContext context, aboutAppResult) {
            return Container(
              height: height,
              color: globalColor.white,
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //============= about section with description ===============
                        // SectionAbout(
                        //   icon: AntDesign.infocirlceo,
                        //   title: Translations.of(context).translate('about_us'),
                        //   description: aboutAppResult.site_desc,
                        // ),
                        // SectionAbout(
                        //   icon: Entypo.address,
                        //   title: Translations.of(context).translate('address'),
                        //   description: aboutAppResult.address,
                        // ),
                        // SectionAboutWithCustomChild(
                        //   icon: MaterialCommunityIcons.contact_mail,
                        //   title:
                        //       Translations.of(context).translate("contact_us"),
                        //   description: buildContactUs(aboutAppResult, width),
                        // ),

                        buildVersionNumberWithPhoto(width),
                      ],
                    ),
                  )),
            );
          },
        ));
  }

  Widget buildVersionNumberWithPhoto(double widthC) {
    return Container(
      width: widthC,
      margin: const EdgeInsets.only(
          top: EdgeMargin.big,
          left: EdgeMargin.min,
          right: EdgeMargin.min,
          bottom: EdgeMargin.subSubMin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            AppAssets.splashLogo,
//            width: ScreenUtil().setWidth(91),
            height: ScreenUtil().setHeight(85),
          ),
          SizedBox(
            height: EdgeMargin.subSubMin,
          ),
        ],
      ),
    );
  }

  Widget buildContactUs(AboutAppResult aboutAppResult, double widthC) {
    return Padding(
      padding: EdgeInsets.only(top: EdgeMargin.sub),
      child: new Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: EdgeMargin.sub),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /*  IconButton(
                  onPressed: () => _lunchSocialMediaAction(context,
                      aboutAppResult != null ? aboutAppResult.address : ""),
                  icon: Icon(
                    MaterialCommunityIcons.web,
                    color: globalColor.primaryColor,
                    size: 30.0,
                  ),
                ),*/
                IconButton(
                  onPressed: () => _callMobile(context,
                      aboutAppResult != null ? aboutAppResult.mobile : ""),
                  icon: SvgPicture.asset(
                    AppAssets.phone_sq,
                    width: 30,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () => _callMobile(context,
                      aboutAppResult != null ? aboutAppResult.phone : ""),
                  icon: SvgPicture.asset(
                    AppAssets.telephone,
                    width: 30,
                    color: globalColor.basic1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    String configEmail =
                        'mailto:${aboutAppResult.email ?? "email@gmail.com"}'
                        '?subject=Email about $APP_NAME   &'
                        'body=Thank you for a such great App';
                    _lunchSocialMediaAction(context, configEmail);
                  },
                  icon: SvgPicture.asset(
                    AppAssets.gmail,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                /*  IconButton(
                  icon: Icon(
                    AntDesign.facebook_square,
                    size: 30.0,
                    color: Color(0xFF3b5998),
                  ),
                  onPressed: () =>
                      _lunchSocialMediaAction(context, aboutAppResult.facebook),
                ),*/
                /*IconButton(
                  icon: Icon(
                    AntDesign.twitter,
                    size: 30.0,
                    color: Colors.blue,
                  ),
                  onPressed: () =>
                      _lunchSocialMediaAction(context, aboutAppResult.twitter),
                ),*/
                IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.instagram,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                  onPressed: () => _lunchSocialMediaAction(
                      context, aboutAppResult.instagram),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _callMobile(BuildContext context, String mobile) async {
    // Android
    if (Platform.isAndroid) {
      var uri = 'tel:+$mobile';
      if (await canLaunch(uri)) await launch(uri);
    } else if (Platform.isIOS) {
      // iOS
      //   var uri = 'tel:+963-949-954-951';

      int j = 0;
      String mobileNumber = "";
      if (mobile != null)
        for (int i = 0; i < mobile.length; ++i, j++) {
          mobileNumber += mobile[i];
          if (j == 2) {
            mobileNumber += "-";
            j = 0;
          }
        }
      var uri = 'tel:+$mobileNumber';
      if (await canLaunch(uri)) await launch(uri);
    } else {
      // var uri = 'tel:+963 949 954 951';
      var uri = 'tel:+$mobile';
      if (await canLaunch(uri))
        await launch(uri);
      else
        onError(context);
    }
  }

  onError(BuildContext context) {
    Fluttertoast.showToast(
      msg: Translations.of(context).translate('err_unexpected'),
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _lunchSocialMediaAction(BuildContext context, String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      onError(context);
    }
  }

  _launchMap(BuildContext context, lat, lng) async {
    var url = '';
    var urlAppleMaps = '';
    if (Platform.isAndroid) {
      url = "https://www.google.com/maps/search/?api=1&query=${lat},${lng}";
    } else {
      urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';
      url = "comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=driving";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else if (await canLaunch(urlAppleMaps)) {
      await launch(urlAppleMaps);
    } else {
      throw 'Could not launch $url';
    }
  }

  buildOurLocation(AboutAppResult aboutAppResult, double widthC) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            aboutAppResult.address,
            style: textStyle.middleTSBasic
                .copyWith(color: globalColor.primaryColor),
            maxLines: 3,
            overflow: TextOverflow.fade,
          ),
          constraints: BoxConstraints(maxWidth: widthC * 0.78),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}
