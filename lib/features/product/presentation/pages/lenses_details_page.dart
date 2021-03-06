import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/button/icon_button_widget.dart';
import 'package:ajb1/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ajb1/core/ui/widget/network/network_widget.dart';
import 'package:ajb1/features/cart/presentation/pages/cart_page.dart';
import 'package:ajb1/features/product/data/models/product_model.dart';
import 'package:ajb1/features/product/domin/entities/product_details_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:ajb1/features/product/domin/usecases/get_product_details.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/widgets/details/lenses_details_shimmer.dart';
import 'package:ajb1/features/product/presentation/widgets/details/lenses_details_widget.dart';
import 'package:ajb1/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart' as Get;

class LensesDetailsPage extends StatefulWidget {
  static const routeName = '/features/ProductDetails/LensesDetailsPage';

  @override
  _LensesDetailsPageState createState() => _LensesDetailsPageState();
}

class _LensesDetailsPageState extends State<LensesDetailsPage> {
  List<String> list = [
    AppAssets.product_details_1,
    AppAssets.product_details_1,
    AppAssets.product_details_1,
    AppAssets.product_details_1,
  ];
  PageController controller =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  var currentPageValue = 0;

  /// add parameters
  bool _addValidation = false;
  String _add = '';
  final TextEditingController addEditingController =
      new TextEditingController();

  /// ipd parameters
  bool _ipdWidthValidation = false;
  String _ipd = '';
  final TextEditingController ipdEditingController =
      new TextEditingController();

  List<ProductModel> listOfProduct = [];

  /* initCategory() {
    listOfProduct = [
      ProductModel(
          type: '????????',
          title: '?????????? ????????',
          image: AppAssets.product_1,
          price: '80',
          colorCountAvailable: '5',
          isFavorite: true,
          rateAvg: '3.5',
          isLenses: false),
      ProductModel(
          type: '????????????',
          title: '?????????? ??????????',
          image: AppAssets.product_2,
          price: '50',
          colorCountAvailable: '10',
          isFavorite: false,
          rateAvg: '5',
          isLenses: false),
      ProductModel(
          type: '????????',
          title: '?????????? ??????????',
          image: AppAssets.men_pro_1,
          price: '80',
          colorCountAvailable: '5',
          isFavorite: true,
          rateAvg: '3.5',
          isLenses: true),
      ProductModel(
          type: '????????????',
          title: '?????????? ??????????',
          image: AppAssets.men_pro_2,
          price: '50',
          colorCountAvailable: '10',
          isFavorite: false,
          rateAvg: '5',
          isLenses: true),
    ];
  }*/

  final args = Get.Get.arguments as ProductDetailsArguments;

  @override
  void initState() {
    super.initState();
  }

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
        IconButtonWidget(
          icon: SvgPicture.asset(
            AppAssets.cart_btnv_svg,
          ),
          onTap: () {
            Get.Get.toNamed(CartPage.routeName);
          },
        ),
        HorizontalPadding(
          percentage: 2.0,
        )
      ],
    );
    //initCategory();
    double width = globalSize.setWidthPercentage(100, context);
    double height = globalSize.setHeightPercentage(100, context) -
        appBar.preferredSize.height -
        MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        backgroundColor: globalColor.scaffoldBackGroundGreyColor,
        appBar: appBar,
        key: _globalKey,
        body: Stack(
          children: [
            Container(
                height: height,
                padding: const EdgeInsets.fromLTRB(EdgeMargin.subMin,
                    EdgeMargin.sub, EdgeMargin.subMin, EdgeMargin.sub),
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
                      return LensesDetailsWidget(
                        width: width,
                        height: height,
                        product: args.product,
                        productDetails: data,
                        cancelToken: _cancelToken,
                      );
                    },
                    loadingWidgetBuilder: (context) {
                      return LensesDetailsShimmer(
                        width: width,
                        height: height,
                        product: args.product,
                      );
                    },
                    fetcher: () {
                      return GetProductDetails(locator<ProductRepository>())(
                        GetProductDetailsParams(
                            id: args.product.id!, cancelToken: _cancelToken),
                      );
                    },
                  ),
                )),
            Positioned(
              bottom: 0.h,
              left: 0.w,
              right: 0.w,
              child:   Container(
                color: Colors.white,
                height: 70.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {},
                      child: Text('Buy Now'),
                      color: Colors.amber,
                      textColor: Colors.black,
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      textColor: Colors.black,
                      child: Text('Add to cart'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
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
