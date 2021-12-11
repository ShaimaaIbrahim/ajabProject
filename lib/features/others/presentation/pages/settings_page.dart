import 'package:ajb1/core/lib/custom_switch/custom_switch.dart';
import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/res/utils.dart';
import 'package:ajb1/core/ui/dailog/language_dailog.dart';
import 'package:ajb1/core/usecases/set_notification.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/about_ojos_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/complaint_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/contact_us_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/membershipe_system_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/questions_answers_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/use_policy_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../../../../main.dart';
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


import '../../../../main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:get/get.dart' as Get;
import 'package:share/share.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/others/pages/SettingsPage';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    var profile = BlocProvider.of<ApplicationBloc>(context).state.profile;
    initalsNotificationsStatus(profile!);
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  bool? statusGetNewProductNotifications;
  bool? statusGetNewOfferNotifications;
  bool? statusGetWalletNotifications;

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
        Translations.of(context).translate('settings'),
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
        body: Container(
            height: height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Get.Get.toNamed(AboutOjosPage.routeName);
                        },
                        title: Translations.of(context).translate('about_ojos'),
                        width: width),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Get.Get.toNamed(UsePolicyPage.routeName);
                        },
                        title: Translations.of(context).translate('use_policy'),
                        width: width),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Get.Get.toNamed(MembershipSystemPage.routeName);
                        },
                        title: Translations.of(context)
                            .translate('membership_system'),
                        width: width),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Get.Get.toNamed(ComplaintPage.routeName);
                        },
                        title: Translations.of(context)
                            .translate('complaints_and_inquiries'),
                        width: width),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Get.Get.toNamed(QuestionsAnswersPage.routeName);
                        },
                        title: Translations.of(context)
                            .translate('questions_and_answers'),
                        width: width),
                    _buildLanguageItem(context: context, width: width),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Share.share(
                            '${Translations.of(context).translate('to_download_app')} \n https://play.google.com/store/apps/details?id=com.tatbiqakum.ojos_app ',
                          );
                        },
                        title: Translations.of(context).translate('share_app'),
                        width: width),
                    _buildMoreItem(
                        context: context,
                        onTap: () {
                          Get.Get.toNamed(ContactUsPage.routeName);
                        },
                        title: Translations.of(context).translate('contact_us'),
                        width: width),
                    BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .isUserAuthenticated ||
                            BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .isUserVerified
                        ? _buildSwitchItem(
                            context: context,
                            onTap: () {},
                            title: Translations.of(context)
                                .translate('get_new_product_notifications'),
                            width: width,
                            status: statusGetNewProductNotifications!)
                        : Container(),
                    BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .isUserAuthenticated ||
                            BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .isUserVerified
                        ? _buildSwitchItemWallet(
                            context: context,
                            onTap: () {},
                            title: Translations.of(context)
                                .translate('get_wallet_notifications'),
                            width: width)
                        : Container(),
                    BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .isUserAuthenticated ||
                            BlocProvider.of<ApplicationBloc>(context)
                                .state
                                .isUserVerified
                        ? _buildSwitchItemOffer(
                            context: context,
                            onTap: () {},
                            title: Translations.of(context)
                                .translate('get_new_offer_notifications'),
                            width: width,
                            status: statusGetNewOfferNotifications!)
                        : Container(),
                    VerticalPadding(
                      percentage: 4.0,
                    ),
                  ],
                ),
              ),
            )));
  }

  initalsNotificationsStatus(ProfileEntity profile) async {
    bool? selectedNewOffer;
    await appSharedPrefs.selectedNotifyNewProduct.then((value) {
      print('omar  cache selectedNotifyNewProduct fun is =  $value');
      selectedNewOffer = value!;
      print('omar  cache selectedNotifyNewProduct fun is=  $selectedNewOffer');
    });
    if (selectedNewOffer == null) {
      if (mounted)
        setState(() {
          statusGetNewProductNotifications =
              /*profile.notify_new_product ??*/ false;
        });
    } else {
      if (mounted)
        setState(() {
          statusGetNewProductNotifications = selectedNewOffer;
        });
    }

    bool? selectedOffer;
    await appSharedPrefs.selectedNotifyOffer.then((value) {
      print('omar  cache selectedNotifyOffer fun is =  $value');
      selectedOffer = value!;
      print('omar  cache selectedNotifyOffer fun is=  $selectedOffer');
    });
    if (selectedOffer == null) {
      if (mounted)
        setState(() {
          statusGetNewOfferNotifications = /*profile.notify_offer ??*/ false;
        });
    } else {
      if (mounted)
        setState(() {
          statusGetNewOfferNotifications = selectedOffer;
        });
    }

    bool? selectedWallet;
    await appSharedPrefs.selectedNotifyWallet.then((value) {
      print('omar  cache selectedNotifyWallet fun is =  $value');
      selectedWallet = value!;
      print('omar  cache selectedNotifyWallet fun is=  $selectedWallet');
    });
    if (selectedWallet == null) {
      if (mounted)
        setState(() {
          statusGetWalletNotifications = /*profile.notify_wallet ??*/ false;
        });
    } else {
      print('omar  statusGetWalletNotifications');
      if (mounted)
        setState(() {
          statusGetWalletNotifications = selectedWallet;
        });
      print('omar  statusGetWalletNotifications $statusGetWalletNotifications');
    }
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }

  _buildMoreItem(
      {required BuildContext context,
      required double width,
      required String title,
      required Function onTap}) {
    return InkWell(
      splashColor: globalColor.transparent,
      hoverColor: globalColor.transparent,
      highlightColor: globalColor.transparent,
      onTap: onTap() ?? () {},
      child: Container(
        padding:
            const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
        child: Card(
            color: globalColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
            child: Container(
              width: width,
              padding: const EdgeInsets.only(
                  left: EdgeMargin.min,
                  right: EdgeMargin.min,
                  bottom: EdgeMargin.min,
                  top: EdgeMargin.min),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: Text(
                        title,
                        style: textStyle.smallTSBasic.copyWith(
                            color: globalColor.black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  HorizontalPadding(
                    percentage: 2.5,
                  ),
                  Container(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: globalColor.geryBorder.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: globalColor.grey.withOpacity(0.3),
                                width: 0.5)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(EdgeMargin.sub,
                              EdgeMargin.sub, EdgeMargin.sub, EdgeMargin.sub),
                          child: Icon(
                            utils.getLang() == 'ar'
                                ? Icons.keyboard_arrow_left
                                : Icons.keyboard_arrow_right,
                            color: globalColor.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _buildSwitchItem(
      {required BuildContext context,
      required double width,
      required String title,
      required Function onTap,
      required bool status}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
      child: Card(
          color: globalColor.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
              color: globalColor.white,
            ),
            padding: const EdgeInsets.only(
                left: EdgeMargin.min,
                right: EdgeMargin.min,
                bottom: EdgeMargin.min,
                top: EdgeMargin.min),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: EdgeMargin.min, right: EdgeMargin.min),
                    child: Text(
                      title,
                      style: textStyle.smallTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                HorizontalPadding(
                  percentage: 2.5,
                ),
                Container(
                  width: 60.0,
                  child: Center(
                    child: Container(
                      child: CustomSwitch(
                        activeColor: globalColor.primaryColor,
                        value: statusGetNewProductNotifications!,
                        onChanged: (value) {
                          print("VALUE : $value");

                          _requestSetNotificationsNewProduct(
                              notify_new_product:
                                  statusGetNewProductNotifications!,
                              notify_offer: statusGetNewOfferNotifications!,
                              notify_wallet: statusGetWalletNotifications!);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _buildSwitchItemOffer(
      {required BuildContext context,
      required double width,
      required String title,
      required Function onTap,
      required bool status}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
      child: Card(
          color: globalColor.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
              color: globalColor.white,
            ),
            padding: const EdgeInsets.only(
                left: EdgeMargin.min,
                right: EdgeMargin.min,
                bottom: EdgeMargin.min,
                top: EdgeMargin.min),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: EdgeMargin.min, right: EdgeMargin.min),
                    child: Text(
                      title,
                      style: textStyle.smallTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                HorizontalPadding(
                  percentage: 2.5,
                ),
                Container(
                  width: 60.0.w,
                  child: Center(
                    child: Container(
                      child: CustomSwitch(
                        activeColor: globalColor.primaryColor,
                        value: statusGetNewOfferNotifications!,
                        onChanged: (value) {
                          print("VALUE : $value");

                          _requestSetNotificationsOffer(
                              notify_new_product:
                                  statusGetNewProductNotifications!,
                              notify_offer: statusGetNewOfferNotifications!,
                              notify_wallet: statusGetWalletNotifications!,
                              value: value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _buildSwitchItemWallet(
      {required BuildContext context,
      required double width,
      required String title,
      required Function onTap}) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
      child: Card(
          color: globalColor.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.0.w)),
              color: globalColor.white,
            ),
            padding: const EdgeInsets.only(
                left: EdgeMargin.min,
                right: EdgeMargin.min,
                bottom: EdgeMargin.min,
                top: EdgeMargin.min),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: EdgeMargin.min, right: EdgeMargin.min),
                    child: Text(
                      title,
                      style: textStyle.smallTSBasic.copyWith(
                          color: globalColor.black,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                HorizontalPadding(
                  percentage: 2.5,
                ),
                Container(
                  width: 60.0.w,
                  child: Center(
                    child: Container(
                      child: CustomSwitch(
                        activeColor: globalColor.primaryColor,
                        value: statusGetWalletNotifications!,
                        onChanged: (value) {
                          print("VALUE : $value");

                          _requestSetNotificationsWallet(
                              notify_new_product:
                                  statusGetNewProductNotifications!,
                              notify_offer: statusGetNewOfferNotifications!,
                              notify_wallet: statusGetWalletNotifications!,
                              value: value);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  _buildLanguageItem({required BuildContext context, required double width}) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => LanguageDialog(),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: EdgeMargin.min, right: EdgeMargin.min),
        child: Card(
            color: globalColor.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0.w))),
            child: Container(
              width: width,
              padding: const EdgeInsets.only(
                  left: EdgeMargin.min,
                  right: EdgeMargin.min,
                  bottom: EdgeMargin.min,
                  top: EdgeMargin.min),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: EdgeMargin.min, right: EdgeMargin.min),
                      child: Text(
                        Translations.of(context)
                            .translate('application_language'),
                        style: textStyle.smallTSBasic.copyWith(
                            color: globalColor.black,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  HorizontalPadding(
                    percentage: 2.5,
                  ),
                  Container(
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: globalColor.geryBorder.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12.0.w),
                            border: Border.all(
                                color: globalColor.grey.withOpacity(0.3),
                                width: 0.5)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(EdgeMargin.sub,
                              EdgeMargin.sub, EdgeMargin.sub, EdgeMargin.sub),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                utils.getLang() == 'ar' ? 'العربية' : 'English',
                                style: textStyle.minTSBasic.copyWith(
                                  color: globalColor.black,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: globalColor.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  _requestSetNotificationsNewProduct(
      {required bool notify_wallet,
      required bool notify_offer,
      required bool notify_new_product,
      bool? value}) async {
    final result = await SetNotificationUseCase(locator<CoreRepository>())(
      SetNotificationParams(
        cancelToken: _cancelToken,
        notify_wallet: notify_wallet,
        notify_offer: notify_offer,
        notify_new_product: notify_new_product,
      ),
    );
    if (result.hasDataOnly) {
      appSharedPrefs.persistSelectedNotifyNewProduct(value);
      if (mounted)
        setState(() {
          statusGetNewProductNotifications = value;
        });
      Fluttertoast.showToast(
          msg: Translations.of(context)
              .translate('settings_successfully_changed'));
    } else if (result.hasErrorOnly || result.hasDataAndError)
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('err_unexpected'));
  }

  _requestSetNotificationsOffer(
      {required bool notify_wallet,
      required bool notify_offer,
      required bool notify_new_product,
      required bool value}) async {
    final result = await SetNotificationUseCase(locator<CoreRepository>())(
      SetNotificationParams(
        cancelToken: _cancelToken,
        notify_wallet: notify_wallet,
        notify_offer: notify_offer,
        notify_new_product: notify_new_product,
      ),
    );
    if (result.hasDataOnly) {
      appSharedPrefs.persistSelectedNotifyOffer(value);
      if (mounted)
        setState(() {
          statusGetNewOfferNotifications = value;
        });
      Fluttertoast.showToast(
          msg: Translations.of(context)
              .translate('settings_successfully_changed'));
    } else if (result.hasErrorOnly || result.hasDataAndError)
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('err_unexpected'));
  }

  _requestSetNotificationsWallet(
      {required bool notify_wallet,
      required bool notify_offer,
      required bool notify_new_product,
      required bool value}) async {
    final result = await SetNotificationUseCase(locator<CoreRepository>())(
      SetNotificationParams(
        cancelToken: _cancelToken,
        notify_wallet: notify_wallet,
        notify_offer: notify_offer,
        notify_new_product: notify_new_product,
      ),
    );
    if (result.hasDataOnly) {
      appSharedPrefs.persistSelectedNotifyWallet(value);
      if (mounted)
        setState(() {
          statusGetWalletNotifications = value;
        });
      Fluttertoast.showToast(
          msg: Translations.of(context)
              .translate('settings_successfully_changed'));
    } else if (result.hasErrorOnly || result.hasDataAndError)
      Fluttertoast.showToast(
          msg: Translations.of(context).translate('err_unexpected'));
  }
}
