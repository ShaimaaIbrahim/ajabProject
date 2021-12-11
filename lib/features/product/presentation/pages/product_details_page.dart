import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/providers/cart_provider.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/button/icon_button_widget.dart';
import 'package:ajb1/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ajb1/core/ui/widget/network/network_widget.dart';
import 'package:ajb1/features/cart/presentation/pages/cart_page.dart';
import 'package:ajb1/features/product/domin/entities/product_details_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:ajb1/features/product/domin/usecases/get_product_details.dart';
import 'package:ajb1/features/product/presentation/widgets/details/product_details_shimmer.dart';
import 'package:ajb1/features/product/presentation/widgets/details/product_details_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as Get;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../main.dart';
import '../args/product_details_args.dart';

class ProductDetailsPage extends StatefulWidget {
  static const routeName = '/features/ProductDetails/ProductDetailsPage';

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // List<ImageInfoEntity> list = [
  //   AppAssets.product_details_1,
  //   AppAssets.product_details_1,
  //   AppAssets.product_details_1,
  //   AppAssets.product_details_1,
  // ];
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;

  /// frame Height parameters
  bool _frameHeightValidation = false;
  String _frameHeight = '';
  final TextEditingController frameHeightEditingController =
      new TextEditingController();

  /// frame Width parameters
  bool _frameWidthValidation = false;
  String _frameWidth = '';
  final TextEditingController frameWidthEditingController =
      new TextEditingController();

  /// frame Length parameters
  bool _frameLengthValidation = false;
  String _frameLength = '';
  final TextEditingController frameLengthEditingController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // _onNavigation(){
  //   Get.Get.back();
  // }

  final args = Get.Get.arguments as ProductDetailsArguments1;
  GlobalKey _globalKey = GlobalKey();
  var _cancelToken = CancelToken();
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('product_details'),
        style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
      ),
      centerTitle: true,
      actions: [
        Consumer<CartProvider>(
          builder: (context, quizProvider, child) {
            return Stack(
              children: [
                IconButtonWidget(
                  icon: SvgPicture.asset(
                    AppAssets.cart_btnv_svg,
                  ),
                  onTap: () {
                    Get.Get.toNamed(CartPage.routeName);
                  },
                ),
                quizProvider.listOfCart != null &&
                        quizProvider.listOfCart.isNotEmpty
                    ? Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: globalColor.red),
                          width: 25,
                          height: 25,
                          child: Center(
                            child: Text(
                              quizProvider.listOfCart.length.toString() ?? '',
                              style: textStyle.minTSBasic
                                  .copyWith(color: globalColor.white),
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            );
          },
        ),
        HorizontalPadding(
          percentage: 2.0,
        )
      ],
    );
    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        // appBar: appBar,
        key: _globalKey,
        body: Container(
            //height: height,
            // padding: const EdgeInsets.fromLTRB(EdgeMargin.subMin,
            //     EdgeMargin.sub, EdgeMargin.subMin, EdgeMargin.sub),
            child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _globalKey = GlobalKey();
            });
            return null;
          },
          child: NetworkWidget<ProductDetailsEntity>(
            connectionErrorWidgetBuilder: (_, __) {
              return ConnectionErrorWidget(callback: reBuildPage);
            },
            unknownErrorWidgetBuilder: (_, __) {
              return UnexpectedErrorWidget(callback: reBuildPage);
            },
            builder: (context, data) {
              return ProductDetailsWidget(
                width: width,
                height: height,
                product: args.product,
                productDetails: data,
                cancelToken: _cancelToken,
              );
            },
            loadingWidgetBuilder: (context) {
              return ProductDetailsShimmer(
                width: width,
                height: height,
                product: args.product,
              );
            },
            fetcher: () {
              print('args.product.id ${args.product.id}');
              return GetProductDetails(locator<ProductRepository>())(
                GetProductDetailsParams(
                    id: args.product.id, cancelToken: _cancelToken),
              );
            },
          ),
        )));
  }

  void reBuildPage() {
    setState(() {
      _globalKey = GlobalKey();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }
}
