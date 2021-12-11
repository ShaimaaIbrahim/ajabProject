import 'package:ajb1/features/brand/presentation/pages/brand_page.dart';
import 'package:ajb1/features/cart/presentation/pages/cart_page.dart';
import 'package:ajb1/features/cart/presentation/pages/check_pay_page.dart';
import 'package:ajb1/features/cart/presentation/pages/enter_cart_info_page.dart';
import 'package:ajb1/features/home/presentation/pages/chewie_video_player.dart';
import 'package:ajb1/features/home/presentation/pages/home_page.dart';
import 'package:ajb1/features/home/presentation/pages/products_view_all_page.dart';
import 'package:ajb1/features/notification/presentation/pages/notification_page.dart';
import 'package:ajb1/features/others/presentation/pages/favorite_page.dart';
import 'package:ajb1/features/others/presentation/pages/offers_page.dart';
import 'package:ajb1/features/others/presentation/pages/settings_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/about_ojos_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/complaint_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/contact_us_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/membershipe_system_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/questions_answers_page.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/terms_condetion.dart';
import 'package:ajb1/features/others/presentation/pages/sub_pages/use_policy_page.dart';
import 'package:ajb1/features/product/presentation/pages/lenses_details_page.dart';
import 'package:ajb1/features/product/presentation/pages/product_details_page.dart';
import 'package:ajb1/features/product/presentation/pages/product_list_page.dart';
import 'package:ajb1/features/profile/presentation/pages/profile_page.dart';
import 'package:ajb1/features/profile/presentation/pages/update_profile_image_page.dart';
import 'package:ajb1/features/reviews/presentation/pages/add_reviews_page.dart';
import 'package:ajb1/features/reviews/presentation/pages/reviews_page.dart';
import 'package:ajb1/features/search/presentation/pages/search_page.dart';
import 'package:ajb1/features/section/presentation/pages/section_page.dart';
import 'package:ajb1/features/user_management/presentation/pages/forgot_password_page.dart';
import 'package:ajb1/features/user_management/presentation/pages/reset_password_page.dart';
import 'package:ajb1/features/user_management/presentation/pages/sign_in_page.dart';
import 'package:ajb1/features/user_management/presentation/pages/sign_up_page.dart';
import 'package:ajb1/features/user_management/presentation/pages/verify_page.dart';
import 'package:ajb1/features/wallet/presentation/pages/wallet_page.dart';
import 'package:get/get.dart';

import '../../main_root.dart';
import '../../splash_screen.dart';


// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = SplashScreen.routeName;

  static final routes = [
    /// user management pages
    GetPage(
      name: SplashScreen.routeName,
      page: () => SplashScreen(),
    ),

    /// user management pages
    GetPage(
      name: SignInPage.routeName,
      page: () => SignInPage(),
    ),
    GetPage(
      name: SignUpPage.routeName,
      page: () => SignUpPage(),
    ),
    GetPage(
      name: VerifyPage.routeName,
      page: () => VerifyPage(),
    ),
    GetPage(
      name: ForgotPage.routeName,
      page: () => ForgotPage(),
    ),
    GetPage(
      name: ResetPage.routeName,
      page: () => ResetPage(),
    ),

    /// main pages
    GetPage(
      name: MainRootPage.routeName,
      page: () => MainRootPage(),
    ),
    GetPage(
      name: HomePage.routeName,
      page: () => HomePage(),
      // binding: RoutePageBinding()
    ),
    GetPage(
      name: SectionPage.routeName,
      page: () => SectionPage(),
    ),
    GetPage(
      name: ProfilePage.routeName,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: UpdateProfileImagePage.routeName,
      page: () => UpdateProfileImagePage(),
    ),
    GetPage(
      name: BrandPage.routeName,
      page: () => BrandPage(),
    ),

    GetPage(
      name: CartPage.routeName,
      page: () => CartPage(),
    ),
    GetPage(
      name: CheckAndPayPage.routeName,
      page: () => CheckAndPayPage(),
    ),

    /// products
    GetPage(
      name: ProductDetailsPage.routeName,
      page: () => ProductDetailsPage(),
    ),
    GetPage(
      name: LensesDetailsPage.routeName,
      page: () => LensesDetailsPage(),
    ),

    GetPage(
      name: ProductListPage.routeName,
      page: () => ProductListPage(),
    ),
    GetPage(
      name: ProductsVeiwAllPage.routeName,
      page: () => ProductsVeiwAllPage(),
    ),

    /// others
    GetPage(
      name: WalletPage.routeName,
      page: () => WalletPage(),
    ),
    GetPage(
      name: OffersPage.routeName,
      page: () => OffersPage(),
    ),

    GetPage(
      name: SettingsPage.routeName,
      page: () => SettingsPage(),
    ),

    GetPage(
      name: ContactUsPage.routeName,
      page: () => ContactUsPage(),
    ),
    GetPage(
      name: FavoritePage.routeName,
      page: () => FavoritePage(),
    ),

    GetPage(
      name: AboutOjosPage.routeName,
      page: () => AboutOjosPage(),
    ),
    GetPage(
      name: UsePolicyPage.routeName,
      page: () => UsePolicyPage(),
    ),
    GetPage(
      name: MembershipSystemPage.routeName,
      page: () => MembershipSystemPage(),
    ),
    GetPage(
      name: QuestionsAnswersPage.routeName,
      page: () => QuestionsAnswersPage(),
    ),
    //
    // GetPage(
    //   name: MyOrderPage.routeName,
    //   page: () => MyOrderPage(),
    // ),

    GetPage(
      name: NotificationPage.routeName,
      page: () => NotificationPage(),
    ),

    GetPage(
      name: ComplaintPage.routeName,
      page: () => ComplaintPage(),
    ),
    GetPage(
      name: ReviewPage.routeName,
      page: () => ReviewPage(),
    ),
    GetPage(
      name: AddReviewPage.routeName,
      page: () => AddReviewPage(),
    ),
    // GetPage(
    //   name: OrderDetailsPageOnline.routeName,
    //   page: () => OrderDetailsPageOnline(),
    // ),
    // GetPage(
    //   name: OrderDetailsPage.routeName,
    //   page: () => OrderDetailsPage(),
    // ),
    GetPage(
      name: TermsCondetion.routeName,
      page: () => TermsCondetion(),
    ),
    GetPage(
      name: SearchPage.routeName,
      page: () => SearchPage(),
    ),

    /// test pages
    // GetPage(
    //   name: MainTestPage.routeName,
    //   page: () => MainTestPage(),
    // ),
    // GetPage(
    //   name: TestResultPage.routeName,
    //   page: () => TestResultPage(),
    // ),
    // GetPage(
    //   name: TestResultVeiwAllPage.routeName,
    //   page: () => TestResultVeiwAllPage(),
    // ),
    GetPage(
      name: EnterCartInfoPage.routeName,
      page: () => EnterCartInfoPage(),
    ),
    GetPage(
      name: OJOSVideoPlayer.routeName,
      page: () => OJOSVideoPlayer(),
    ),
  ];
}
