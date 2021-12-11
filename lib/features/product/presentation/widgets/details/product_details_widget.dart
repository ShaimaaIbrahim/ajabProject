import 'package:ajb1/core/bloc/application_bloc.dart';
import 'package:ajb1/core/providers/cart_provider.dart';
import 'package:ajb1/core/res/screen/horizontal_padding.dart';
import 'package:ajb1/core/ui/dailog/add_to_cart_dialog.dart';
import 'package:ajb1/core/ui/dailog/login_first_dialog.dart';
import 'package:ajb1/core/ui/widget/title_with_view_all_widget.dart';
import 'package:ajb1/features/home/domain/model/product_model.dart';
import 'package:ajb1/features/product/domin/entities/cart_entity.dart';
import 'package:ajb1/features/product/domin/entities/product_details_entity.dart';
import 'package:ajb1/features/product/domin/repositories/product_repository.dart';
import 'package:ajb1/features/product/domin/usecases/add_remove_favorite.dart';
import 'package:ajb1/features/user_management/domain/repositories/user_repository.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as Get;
import 'dart:ui';

import 'package:ajb1/core/res/app_assets.dart';
import 'package:ajb1/core/res/edge_margin.dart';
import 'package:ajb1/core/res/screen/vertical_padding.dart';
import 'package:ajb1/core/res/text_size.dart';
import 'package:ajb1/core/res/utils.dart';
import 'package:ajb1/core/ui/widget/image/image_caching.dart';
import 'package:ajb1/features/product/domin/entities/product_entity.dart';
import 'package:ajb1/features/product/presentation/args/product_details_args.dart';
import 'package:ajb1/features/product/presentation/pages/lenses_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as Get;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ajb1/core/localization/translations.dart';
import 'package:ajb1/core/res/global_color.dart';
import 'package:ajb1/core/res/text_style.dart';
import 'package:ajb1/core/res/width_height.dart';
import 'package:ajb1/core/ui/button/arrow_back_button_widget.dart';
import 'package:ajb1/core/ui/list/build_grid_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as Get;
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../main.dart';
import '../../../domin/entities/general_item_entity.dart';
import '../item_color_product_details.dart';
import '../item_product_home_widget.dart';
import '../item_size_product_details.dart';

class ProductDetailsWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final OffersAndDiscount product;
  final ProductDetailsEntity productDetails;
  final CancelToken cancelToken;

  const ProductDetailsWidget(
      {required this.height,
      required this.width,
      required this.product,
      required this.productDetails,
      required this.cancelToken});

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
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
  bool? isAuth;

  bool _isDisplaySizeList = true;

  List<int>? listOfColorSelected;

  GeneralItemEntity? color;
  List<int>? listOfSizeMode;

  int? SizeModeId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listOfColorSelected = [];
    listOfSizeMode = [];
    color = null;
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? globalSize.setWidthPercentage(100, context);
    final height =
        widget.height ?? globalSize.setHeightPercentage(100, context);

    isAuth =
        BlocProvider.of<ApplicationBloc>(context).state.isUserAuthenticated ||
            BlocProvider.of<ApplicationBloc>(context).state.isUserVerified;
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            color: globalColor.white,
            // borderRadius: BorderRadius.all(Radius.circular(12.w))
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              _buildFrontWidget(),
              _buildTopWidget(
                  context: context,
                  width: width,
                  height: height,
                  discountPrice: widget.productDetails.discount_price,
                  discountType: widget.productDetails.discount_type,
                  product: widget.productDetails),
              _buildSimilarProducts(
                  context: context, width: width, height: height),
            ],
          ),
        ),
      ),
    );
  }

  _buildFrontWidget() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.close,
            color: Colors.green,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              SizedBox(
                width: 10.w,
              ),
              Icon(
                Icons.flag,
                color: Colors.green,
              ),
            ],
          )
        ],
      ),
    );
  }

  _buildTopWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required String discountType,
      required int discountPrice,
      required ProductDetailsEntity product}) {
    return Container(
      width: width,
      color: Colors.white,
      // padding: const EdgeInsets.fromLTRB(EdgeMargin.sub, EdgeMargin.verySub,
      //     EdgeMargin.sub, EdgeMargin.verySub),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: 236.h,
              child: ImageCacheWidget(
                imageUrl:
                    'https://image.freepik.com/free-photo/beef-burger-with-chopped-onions-tomatoes-inside-bread-bun-with-french-fries-stone-platter_114579-1865.jpg',
                imageWidth: width,
                imageHeight: 236.h,
                boxFit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'خبز لوزين ساندوتش رول 4 حبات',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '1.75 SAR/ one ',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 50.h,
              margin: EdgeInsets.only(left: 20.w, right: 20.w),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(5.r)),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'اضافة للعربة',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildTitleAndPriceWidget({
    required BuildContext context,
    required double width,
    required double height,
    required int price,
    required int priceAfterDiscount,
    required int discountPrice,
    required String discountType,
    required String name,
  }) {
    return Container(
      width: width,
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      child: Column(
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                VerticalPadding(
                  percentage: 1.5,
                ),
                Container(
                  child: Text(
                    '${name ?? ''}' ?? '',
                    style: textStyle.middleTSBasic.copyWith(
                      color: globalColor.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  alignment: AlignmentDirectional.centerStart,
                ),
              ],
            ),
          ),
          Container(
              //  alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.fromLTRB(EdgeMargin.verySub,
                  EdgeMargin.sub, EdgeMargin.verySub, EdgeMargin.sub),
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(
                        EdgeMargin.subSubMin,
                        EdgeMargin.verySub,
                        EdgeMargin.subSubMin,
                        EdgeMargin.verySub),
                    child: _buildPriceWidget(
                        discountPrice: discountPrice,
                        price: price,
                        priceAfterDiscount: priceAfterDiscount),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  _onSelectSize(GeneralItemEntity size, bool isSelected) {
    if (isSelected) {
      if (mounted) {
        setState(() {
          SizeModeId = size.id;
          //  listOfSizeMode.add(size.id);
        });
      }
    } else {
      if (mounted)
        setState(() {
          //  listOfSizeMode.removeWhere((element) => element == size.id);
        });
    }

    // print('listOfSizeMode ${listOfSizeMode.toString()}');
  }

  _onSelectColors(GeneralItemEntity colors, bool isSelected) {
    if (isSelected) {
      if (mounted) {
        setState(() {
          color = colors;
          // listOfColorSelected.add(colors.id);
        });
      }
    } else {
      if (mounted)
        setState(() {
          // listOfColorSelected.removeWhere((element) => element == colors.id);
        });
    }

    //  print('listOfYourSelected ${listOfColorSelected.toString()}');
  }

  _buildAddToCartAndFavoriteWidget(
      {required BuildContext context,
      required double width,
      required double height,
      required ProductDetailsEntity productEntity,
      required bool isAuth}) {
    return Container(
      padding:
          const EdgeInsets.fromLTRB(EdgeMargin.min, 0.0, EdgeMargin.min, 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<CartProvider>(
            builder: (context, quizProvider, child) {
              return Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () async {
                    if (await UserRepository.hasToken && isAuth) {
                      // if((color!=null&&color.id!=null) && SizeModeId!=null ){
                      //
                      //
                      // }else{
                      //   appConfig.showToast(msg:Translations.of(context).translate('you_must_choose_size_and_color'));
                      // }

                      quizProvider.addItemToCart(CartEntity(
                          id: productEntity.id,
                          productEntity: productEntity,
                          // isGlasses: productEntity.isGlasses,
                          // colorId: color?.id,
                          // lensSize: null,
                          // sizeForLeftEye: null,
                          // SizeModeId: SizeModeId,
                          // sizeForRightEye: null,
                          // argsForGlasses: selectLensesArgs,
                          count: 1));
                      print('${quizProvider.getItems()!.length}');
                      showDialog(
                        context: context,
                        builder: (ctx) => AddToCartDialog(),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (ctx) => LoginFirstDialog(),
                      );
                    }

                    // quizProvider.addItemToCart(CartEntity(
                    //     id: productEntity.id,
                    //     productEntity: productEntity,
                    //     isGlasses: productEntity.isGlasses,
                    //     addSize: null,
                    //     ipdSize: null,
                    //     sizeForLeftEye: null,
                    //     sizeForRightEye: null,
                    //     count: 1));
                    // print('${quizProvider.getItems().length}');
                    // showDialog(
                    //   context: context,
                    //   builder: (ctx) => AddToCartDialog(),
                    // );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: globalColor.primaryColor,
                      borderRadius: BorderRadius.circular(16.0.w),
                      // border: Border.all(
                      //     width: 0.5,
                      //     color: globalColor.grey.withOpacity(0.3))
                    ),
                    height: 40.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Translations.of(context).translate('add_to_cart'),
                            style: textStyle.smallTSBasic.copyWith(
                                fontWeight: FontWeight.w500,
                                color: globalColor.white),
                          ),
                        ),
                        SvgPicture.asset(
                          AppAssets.cart_nav_bar,
                          color: globalColor.white,
                          width: 20.w,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  _buildSimilarProducts(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      child: widget.productDetails.product_as_same != null &&
              widget.productDetails.product_as_same.isNotEmpty
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: EdgeMargin.small, right: EdgeMargin.small),
                  child: TitleWithViewAllWidget(
                    width: width,
                    title:
                        Translations.of(context).translate('similar_products'),
                    onClickView: () {},
                    strViewAll: Translations.of(context).translate('view_all'),
                  ),
                ),
                Container(
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.productDetails.product_as_same.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio:
                              globalSize.setWidthPercentage(47, context) /
                                  globalSize.setWidthPercentage(60, context),
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ItemProductHomeWidget(
                            fromHome: true,
                            height: globalSize.setWidthPercentage(60, context),
                            width: globalSize.setWidthPercentage(47, context),
                            product:
                                widget.productDetails.product_as_same[index],
                          );
                        }))
              ],
            )
          : Container(),
    );
  }

  _divider() {
    return Divider(
      color: globalColor.grey.withOpacity(0.3),
      height: 8.h,
    );
  }

  _buildPriceWidget(
      {required int price,
      required int discountPrice,
      required int priceAfterDiscount}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: '${price.toString() ?? ''}',
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.lineThrough,
                          color: globalColor.grey),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.grey)),
                      ],
                    ),
                  ),
                ))
              : Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: price.toString() ?? '',
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          color: globalColor.primaryColor),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.black)),
                      ],
                    ),
                  ),
                )),
          HorizontalPadding(percentage: 2.5),
          discountPrice != null && discountPrice != 0.0
              ? Container(
                  child: FittedBox(
                  child: RichText(
                    text: TextSpan(
                      text: priceAfterDiscount.toString(),
                      style: textStyle.middleTSBasic.copyWith(
                          fontWeight: FontWeight.bold,
                          color: globalColor.primaryColor),
                      children: <TextSpan>[
                        new TextSpan(
                            text:
                                ' ${Translations.of(context).translate('rail')}',
                            style: textStyle.smallTSBasic
                                .copyWith(color: globalColor.black)),
                      ],
                    ),
                  ),
                ))
              : Container(),
        ],
      ),
    );
  }
}
