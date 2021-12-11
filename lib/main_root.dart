import 'dart:ui';

import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Get;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';
import 'core/bloc/application_bloc.dart';
import 'core/bloc/application_events.dart';
import 'core/bloc/application_state.dart';
import 'core/bloc/root_page_bloc.dart';
import 'core/constants.dart';
import 'core/localization/translations.dart';
import 'core/notification/notifications_service.dart';
import 'core/repositories/core_repository.dart';
import 'core/res/app_assets.dart';
import 'core/res/global_color.dart';
import 'core/res/screen/screen_helper.dart';
import 'core/res/text_style.dart';
import 'core/res/utils.dart';
import 'core/res/width_height.dart';
import 'core/ui/dailog/confirm_dialog.dart';
import 'core/ui/dailog/language_dailog.dart';
import 'core/ui/dailog/login_first_dialog.dart';
import 'core/ui/dailog/soon_dailog.dart';
import 'core/ui/widget/network/network_widget.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/home/presentation/pages/products_view_all_page.dart';
import 'features/notification/presentation/pages/notification_page.dart';
import 'features/order/presentation/pages/orders_page.dart';
import 'features/others/domain/entity/about_app_result.dart';
import 'features/others/domain/usecases/get_about_app.dart';
import 'features/others/presentation/pages/favorite_page.dart';
import 'features/others/presentation/pages/offers_page.dart';
import 'features/others/presentation/pages/settings_page.dart';
import 'features/others/presentation/pages/sub_pages/terms_condetion.dart';
import 'features/others/presentation/pages/sub_pages/use_policy_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/reviews/presentation/pages/reviews_page.dart';
import 'features/user_management/domain/repositories/user_repository.dart';
import 'features/user_management/presentation/pages/sign_in_page.dart';

var _cancelToken = CancelToken();

BuildContext? testContext;
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
final notificationsService = NotificationsService();

class MainRootPage extends StatefulWidget {
  static const routeName = '/features/MainRootPage';
  final BuildContext? menuScreenContext;

  MainRootPage({this.menuScreenContext});

  @override
  _MainRootPageState createState() => _MainRootPageState();
}

class _MainRootPageState extends State<MainRootPage>
    with SingleTickerProviderStateMixin {
  PersistentTabController? _controller;
  bool? _hideNavBar;

  TabController? tabController;
  DateTime? currentBackPressTime;
  bool? isAuth;

  String stateLog = '';
  String? stateAsset;
  MenuSpecItem? stateMenu;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
    tabController!.addListener(() {
      if (tabController!.indexIsChanging) setState(() {});
    });
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
    notificationsService.selectNotificationSubject.listen((payload) {
      print('payload is : $payload');
      // if (notificationsService != null)
      //   notificationsService.onNotificationPressed(context, payload);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = globalSize.setHeightPercentage(100, context) -
        // appBar().preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    isAuth =
        BlocProvider.of<ApplicationBloc>(context).state.isUserAuthenticated ||
            BlocProvider.of<ApplicationBloc>(context).state.isUserVerified;

    if (isAuth!) {
      setState(() {
        stateLog = 'logout';
        stateAsset = AppAssets.logout_svg;
        stateMenu = MenuSpecItem.SignOut;
      });
    } else {
      setState(() {
        stateLog = 'login';
        stateAsset = AppAssets.login_svg;
        stateMenu = MenuSpecItem.SignInPage;
      });
    }

    return BlocListener<RootPageBloc, RootPageState>(
      listener: (context, state) {
        if (state is PageIndexState) {
          if (state.pageIndex != null) {
            tabController!.index = state.pageIndex;
            setState(() {});
          }
        }
      },
      child: BlocBuilder(
        bloc: BlocProvider.of<ApplicationBloc>(context),
        builder: (BuildContext context, state) => Scaffold(
          backgroundColor: globalColor.scaffoldBackGroundGreyColor,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(14.w)),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        left: 05.0, right: 5.0, bottom: 5.0),
                    color: globalColor.transparent,
                    child: Container(
                      height: 65.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(14.w)),
                          color: globalColor.white),
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: Colors.transparent,
                        indicatorPadding: EdgeInsets.all(0.0),
                        labelPadding: EdgeInsets.all(0.0),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: <Widget>[
                          _buildTabItem(
                            Translations.of(context).translate('home'),
                            AppAssets.home,
                            PagesEnum.HOME_PAGE,
                          ),
                          _buildTabItem(
                              Translations.of(context)
                                  .translate('offers_drawer'),
                              AppAssets.offer,
                              PagesEnum.BRAND_PAGE),
                          _buildTabItem(
                              Translations.of(context)
                                  .translate('order_drawer'),
                              AppAssets.orders,
                              PagesEnum.CART_PAGE),
                          InkWell(
                            onTap: () {
                              Get.Get.to(GetDrawer(state, height,
                                  getListMaterialResideMenuItem1));
// Navigator.push(context, MaterialPageRoute(builder: (context) =>                           GetDrawer(),))                          print("aaaaaaa");
                            },
                            child: _buildTabItem(
                              Translations.of(context).translate('settings'),
                              AppAssets.settings,
                              PagesEnum.SettingsPage,
                            ),
                          ),

//                  if(!appSharedPrefs.isGuest)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: WillPopScope(
            onWillPop: _onWillPop,
            child: Container(
              child: TabBarView(
                controller: tabController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  HomePage(
                    tabController: tabController,
                  ),
                  ProductsVeiwAllPage(
                    appBarTitle: "--",
                    fromHome: false,
                  ),
                  Orderspage(),
                  GetDrawer(state, height, getListMaterialResideMenuItem1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card getMaterialResideMenuItem(String drawerMenuTitle, String? drawerMenuIcon,
      {MenuSpecItem? state,
      bool ishideArrow = true,
      tralingfunc,
      leadingWidget}) {
    return Card(
      child: new InkWell(
        onTap: () {
          if (state == null)
            tralingfunc();
          else {
            _onItemMenuPress(state);
          }
          //
        },
        child: Container(
            //
            // margin: EdgeInsets.only(
            //   right: isRtl(context) ? 10.0 : 0.0,
            // ),
            child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    drawerMenuIcon ?? AppAssets.home_nav_bar,
                    color: globalColor.primaryColor,
                    width: 20,
                  ),
                  Container(
                    width: 30,
                  ),
                  Text(
                    Translations.of(context).translate(drawerMenuTitle),
                    style: textStyle.normalTSBasic
                        .copyWith(color: globalColor.black),
                  )
                ],
              ),
              margin: EdgeInsets.only(left: 12.0, top: 5, bottom: 5),
            ),
            Padding(
              child: ishideArrow
                  ? Container()
                  : Container(
                      child: leadingWidget == null
                          ? Icon(
                              utils.getLang() == 'ar'
                                  ? Icons.keyboard_arrow_left
                                  : Icons.keyboard_arrow_right,
                              color: globalColor.primaryColor,
                              size: 25,
                            )
                          : leadingWidget,
                    ),
              padding: EdgeInsets.only(right: 0),
            )
          ],
        )

            // Rs.ResideMenuItem(
            //   titleStyle:
            //       textStyle.normalTSBasic.copyWith(color: globalColor.white),
            //   title: drawerMenuTitle,
            //   leftSpacing: 12.0,
            //   right: ishideArrow ? Container() :
            //   Container(
            //     child: Icon(
            //       utils.getLang() == 'ar'
            //           ? MaterialIcons.keyboard_arrow_left
            //           : MaterialIcons.keyboard_arrow_right,
            //       color: globalColor.primaryColor,
            //       size: 25,
            //     ),
            //   ),
            //   icon: SvgPicture.asset(
            //     drawerMenuIcon ?? AppAssets.home_nav_bar,
            //     color: globalColor.primaryColor,
            //     width: 20,
            //   ),
            // ),
            ),
      ),
    );
  }

  _onItemMenuPress(MenuSpecItem state) async {
    switch (state) {
      case MenuSpecItem.HomePage:
        break;
      case MenuSpecItem.ProfilePage:
        if (await UserRepository.hasToken && isAuth!) {
          Get.Get.toNamed(ProfilePage.routeName);
        } else {
          showDialog(
            context: context,
            builder: (ctx) => LoginFirstDialog(),
          );
        }

        break;
      case MenuSpecItem.BrandPage:
        tabController!.animateTo(1);
        break;
      case MenuSpecItem.OrderPage:
        tabController!.animateTo(4);
        break;
      case MenuSpecItem.SectionPage:
        tabController!.animateTo(3);
        break;
      case MenuSpecItem.WalletPage:
        // if (await UserRepository.hasToken && isAuth) {
        //   Get.Get.toNamed(WalletPage.routeName);
        // }
        // else {
        //   showDialog(
        //     context: context,
        //     builder: (ctx) => LoginFirstDialog(),
        //   );
        // }
        showDialog(
          context: context,
          builder: (ctx) => SoonDialog(),
        );

        break;
      case MenuSpecItem.FavoritePage:
        if (await UserRepository.hasToken && isAuth!) {
          Get.Get.toNamed(FavoritePage.routeName);
        } else {
          showDialog(
            context: context,
            builder: (ctx) => LoginFirstDialog(),
          );
        }

        break;
      case MenuSpecItem.ReviewsPage:
        if (await UserRepository.hasToken && isAuth!) {
          Get.Get.toNamed(ReviewPage.routeName);
        } else {
          showDialog(
            context: context,
            builder: (ctx) => LoginFirstDialog(),
          );
        }

        break;
      case MenuSpecItem.OffersPage:
        Get.Get.toNamed(OffersPage.routeName);
        break;
      case MenuSpecItem.SettingsPage:
        Get.Get.toNamed(SettingsPage.routeName);
        break;
      case MenuSpecItem.SignInPage:
        Get.Get.toNamed(SignInPage.routeName);
        break;
      case MenuSpecItem.SignOut:
        showDialog(
          context: context,
          builder: (ctx) => ConfirmDialog(
            title: Translations.of(context).translate('logout'),
            confirmMessage:
                Translations.of(context).translate('are_you_sure_logout'),
            actionYes: () {
              setState(() {
                BlocProvider.of<ApplicationBloc>(context)
                    .add(UserLogoutEvent());
                isAuth = false;
              });
              Get.Get.back();
            },
            actionNo: () {
              setState(() {
                Get.Get.back();
              });
            },
          ),
        );
        break;
      default:
        break;
    }
  }

  Widget getMaterialResideMenuItem2(
      String drawerMenuTitle, String drawerMenuIcon,
      {MenuSpecItem? state,
      bool ishideArrow = true,
      tralingfunc,
      leadingWidget}) {
    return new InkWell(
      onTap: () {
        if (state == null)
          tralingfunc();
        else {
          // _menuController.closeMenu();
          _onItemMenuPress(state);
        }
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: globalColor.primaryColor,
              ),
              borderRadius: BorderRadius.circular(6)),
          margin: EdgeInsets.only(
              // right: isRtl(context) ? 10.0 : 0.0,
              ),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      Translations.of(context).translate(drawerMenuTitle),
                      style: textStyle.normalTSBasic.copyWith(
                        color: globalColor.primaryColor,
                      ),
                    )
                  ],
                ),
                margin:
                    EdgeInsets.only(left: 12.0, top: 1, bottom: 1, right: 12),
              ),
              // Padding(
              //   child: ishideArrow
              //       ? Container()
              //       : Container(
              //           child: leadingWidget == null
              //               ? Icon(
              //                   utils.getLang() == 'ar'
              //                       ? MaterialIcons.keyboard_arrow_left
              //                       : MaterialIcons.keyboard_arrow_right,
              //                   color: globalColor.primaryColor,
              //                   size: 25,
              //                 )
              //               : leadingWidget,
              //         ),
              //   padding: EdgeInsets.only(right: 0),
              // )
            ],
          )

          // Rs.ResideMenuItem(
          //   titleStyle:
          //       textStyle.normalTSBasic.copyWith(color: globalColor.white),
          //   title: drawerMenuTitle,
          //   leftSpacing: 12.0,
          //   right: ishideArrow ? Container() :
          //   Container(
          //     child: Icon(
          //       utils.getLang() == 'ar'
          //           ? MaterialIcons.keyboard_arrow_left
          //           : MaterialIcons.keyboard_arrow_right,
          //       color: globalColor.primaryColor,
          //       size: 25,
          //     ),
          //   ),
          //   icon: SvgPicture.asset(
          //     drawerMenuIcon ?? AppAssets.home_nav_bar,
          //     color: globalColor.primaryColor,
          //     width: 20,
          //   ),
          // ),
          ),
    );
  }

  List<Widget> getListMaterialResideMenuItem1(
    ApplicationState state,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildColumnItme(
                'edit_profile_drawer', AppAssets.profile_nav_bar, context),
          ),
          HorizontalPadding(
            percentage: 20.w,
          ),
          Expanded(
            flex: 1,
            child: _buildColumnItme(
                'application_language', AppAssets.worldLang, context),
          ),
          HorizontalPadding(
            percentage: 20.w,
          ),
          Expanded(
            flex: 1,
            child: _buildColumnItme('offers_drawer', AppAssets.sales, context),
          )
        ],
      ),
      Container(
        height: 20.h,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: _buildColumnItme('favorite_drawer', AppAssets.love, context),
          ),
          HorizontalPadding(
            percentage: 20.w,
          ),
          Expanded(
            flex: 1,
            child:
                _buildColumnItme('use_policy', AppAssets.use_policy, context),
          ),
          HorizontalPadding(
            percentage: 20.w,
          ),
          Expanded(
            flex: 1,
            child: _buildColumnItme(
                'notifications1', AppAssets.notification, context),
          )
        ],
      ),
      // getMaterialResideMenuItem(
      //    'home', AppAssets.home_nav_bar,
      //     state: MenuSpecItem.HomePage),

      // _buildColumnItme('edit_profile_drawer', AppAssets.profile_nav_bar),
      // getMaterialResideMenuItem(
      //     'edit_profile_drawer', AppAssets.profile_nav_bar, tralingfunc: () {
      //   Get.Get.toNamed(ProfilePage.routeName);
      // }, state: MenuSpecItem.ProfilePage),
      //
      // getMaterialResideMenuItem('application_language', AppAssets.worldLang,
      //     tralingfunc: () {
      //   return showDialog(
      //     context: context,
      //     builder: (_) => LanguageDialog(),
      //   );
      // },
      //     ishideArrow: false,
      //     leadingWidget: Row(
      //       children: [
      //         Text(
      //           utils.getLang() == 'ar' ? 'العربية' : 'English',
      //           style: textStyle.minTSBasic.copyWith(
      //               color: Color(0xff227987),
      //               decoration: TextDecoration.underline),
      //         ),
      //         SizedBox(
      //           width: 2,
      //         ),
      //         Icon(
      //           Icons.keyboard_arrow_down_sharp,
      //           color: Color(0xff227987),
      //         ),
      //         SizedBox(
      //           width: 2,
      //         ),
      //       ],
      //     )),
      //
      // getMaterialResideMenuItem(
      //   'notifications1',
      //   AppAssets.notification,
      //   tralingfunc: () async {
      //     if (await UserRepository.hasToken && isAuth!) {
      //       Get.Get.toNamed(NotificationPage.routeName);
      //     } else {
      //       showDialog(
      //         context: context,
      //         builder: (ctx) => LoginFirstDialog(),
      //       );
      //     }
      //   },
      //   ishideArrow: true,
      // ),
      //
      //
      // getMaterialResideMenuItem('offers_drawer', AppAssets.sales,
      //     state: MenuSpecItem.OffersPage),
      //
      // getMaterialResideMenuItem('favorite_drawer', AppAssets.love,
      //     tralingfunc: () {
      //   Get.Get.toNamed(FavoritePage.routeName);
      // }, state: MenuSpecItem.FavoritePage),
      //
      // InkWell(
      //   onTap: () {
      //     //  Get.Get.to(OnlineOrder());
      //   },
      //   child: getMaterialResideMenuItem('custom_order', AppAssets.order_drawer,
      //       tralingfunc: () {
      //     //  Get.Get.to(OnlineOrder());
      //   },
      //       leadingWidget: Container(
      //         width: 2000,
      //       )),
      // ),
      //
      // InkWell(
      //   onTap: () {
      //     // Get.Get.to(MyOrderPage());
      //   },
      //   child: getMaterialResideMenuItem(
      //       'Product_requests', AppAssets.order_drawer, tralingfunc: () {
      //     // Get.Get.to(MyOrderPage());
      //   },
      //       leadingWidget: Container(
      //         width: 2000,
      //       )),
      // ),
      //
      // //
      // // getMaterialResideMenuItem('rated_drawer', AppAssets.review_drawer,
      // //     state: MenuSpecItem.ReviewsPage),
      //
      // InkWell(
      //   onTap: () {
      //     Get.Get.toNamed(TermsCondetion.routeName);
      //   },
      //   child: getMaterialResideMenuItem(
      //       'Terms and Conditions', AppAssets.user_privacy, tralingfunc: () {
      //     Get.Get.toNamed(TermsCondetion.routeName);
      //   },
      //       leadingWidget: Container(
      //         width: 2000,
      //       )),
      // ),
      //
      // InkWell(
      //   onTap: () {
      //     Get.Get.toNamed(UsePolicyPage.routeName);
      //   },
      //   child: getMaterialResideMenuItem('use_policy', AppAssets.use_policy,
      //       tralingfunc: () {
      //     Get.Get.toNamed(UsePolicyPage.routeName);
      //   },
      //       leadingWidget: Container(
      //         width: 2000,
      //       )),
      // ),
      //
      Container(
        height: 50.h,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NetworkWidget(
            builder: (BuildContext context, AboutAppResult aboutAppResult) {
              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _lunchSocialMediaAction(context, aboutAppResult.twitter);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(AppAssets.twitter,
                              color: Colors.white),
                        ),
                        backgroundColor: globalColor.primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _lunchSocialMediaAction(
                          context, aboutAppResult.instagram);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(AppAssets.instagram,
                              color: Colors.white),
                        ),
                        backgroundColor: globalColor.primaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String configEmail =
                          'mailto:${aboutAppResult.email ?? "email@gmail.com"}'
                          '?subject=Email about $APP_NAME   &'
                          'body=Thank you for a such great App';
                      _lunchSocialMediaAction(context, configEmail);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        child: Icon(Icons.email_outlined,
                            color: globalColor.white),
                        backgroundColor: globalColor.primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            },
            loadingWidgetBuilder: (BuildContext context) {
              return Container(
                  // width: 60,
                  // height: 60,
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            globalColor.primaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            globalColor.primaryColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            globalColor.primaryColor),
                      ),
                    ),
                  ),
                ],
              ));
            },
            fetcher: () {
              return GetAboutApp(locator<CoreRepository>())(
                GetAboutAppParams(
                  cancelToken: _cancelToken,
                ),
              );
            },
          ),
          isAuth!
              ? StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                  return InkWell(
                    onTap: () {
                      _onItemMenuPress(MenuSpecItem.SignOut);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: globalColor.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        margin: EdgeInsets.only(
                            // right: isRtl(context) ? 10.0 : 0.0,
                            ),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    Translations.of(context)
                                        .translate('logout'),
                                    style: textStyle.normalTSBasic.copyWith(
                                      color: globalColor.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  left: 12.0, top: 1, bottom: 1, right: 12),
                            ),
                          ],
                        )),
                  );
                })
              : StatefulBuilder(builder: (BuildContext context,
                  void Function(void Function()) setState) {
                  return InkWell(
                    onTap: () {
                      _onItemMenuPress(MenuSpecItem.SignInPage);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: globalColor.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        margin: EdgeInsets.only(
                            // right: isRtl(context) ? 10.0 : 0.0,
                            ),
                        child: new Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    Translations.of(context).translate('login'),
                                    style: textStyle.normalTSBasic.copyWith(
                                      color: globalColor.primaryColor,
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  left: 12.0, top: 1, bottom: 1, right: 12),
                            ),
                          ],
                        )),
                  );
                })
        ],
      ),
    ];
  }

  void _lunchSocialMediaAction(BuildContext context, String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      onError(context);
    }
  }

  onError(BuildContext context) {
    Fluttertoast.showToast(
      msg: Translations.of(context).translate('err_unexpected'),
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  void dispose() {
    tabController!.dispose();
    notificationsService.dispose();
    super.dispose();
  }

  Widget _buildTabItem(String text, String iconPath, PagesEnum page,
      [ispng = false, onTap]) {
    bool isSelected = (page.index == tabController!.index);

    final iconColor = isSelected ? globalColor.primaryColor : globalColor.black;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: ScreensHelper.fromHeight(0.5)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ispng
                ? AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    // width: ScreensHelper.fromWidth(isSelected ? 7.0 : 6.5),
                    // height: ScreensHelper.fromHeight(isSelected ? 7.0 : 6.5),
                    width: 25,
                    height: 25,
                    child: FittedBox(
                      child: Image.asset(
                        iconPath,
                        color: iconColor,
                      ),
                    ),
                  )
                : AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    width: 25,
                    height: 25,
                    // width: ScreensHelper.fromWidth(isSelected ? 6.0 : 5.5),
                    // height: ScreensHelper.fromHeight(isSelected ? 3.75 : 3.3),
                    child: FittedBox(
                      child: Image.asset(
                        iconPath,
                        color: iconColor,
                      ),
                    ),
                  ),
            Container(
              child: Text(
                text,
                style: textStyle.minTSBasic
                    .copyWith(color: iconColor, fontWeight: FontWeight.w200),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (checkIndex()) return Future.value(false);

    if (tabController!.index != PagesEnum.HOME_PAGE.index) {
      BlocProvider.of<RootPageBloc>(context)
          .add(ChangePageEvent(PagesEnum.HOME_PAGE.index));
      return Future.value(false);
    }
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: Translations.of(context).translate('tab_to_exit'),
        backgroundColor: globalColor.primaryColor,
      );
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }

  bool checkIndex() {
    if (tabController!.index == 0) return false;
    // botNavBar.onTap(0);
    tabController!.animateTo(0);
    return true;
  }
}

_buildColumnItme(title, icon, context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          width: 70.w,
          height: 70.h,
          decoration:
              BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
          child: Center(
            child: SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.h,
              color: Colors.black,
            ),
          )),
      SizedBox(height: 5.h),
      Text(
        Translations.of(context).translate(title),
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      )
    ],
  );
}

enum PagesEnum {
  HOME_PAGE,
  BRAND_PAGE,
  CART_PAGE,
  SettingsPage,
  PROFILE_PAGE,
}
