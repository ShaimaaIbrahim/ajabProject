import 'package:ajb1/core/errors/connection_error.dart';
import 'package:ajb1/core/errors/custom_error.dart';
import 'package:ajb1/core/ui/widget/general_widgets/error_widgets.dart';
import 'package:ajb1/features/others/presentation/blocs/contact_us_bloc.dart';
import 'package:ajb1/xternal_lib/model_progress_hud.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class ContactUsPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/ContactUsPage';

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  /// message parameters
  bool _messageValidation = false;
  String _message = '';
  final TextEditingController messageEditingController =
      new TextEditingController();

  /// phone parameters
  bool _phoneValidation = false;
  String _phone = '';
  final TextEditingController phoneEditingController =
      new TextEditingController();

  /// fullName parameters
  bool _fullNameValidation = false;
  String _fullName = '';
  final TextEditingController fullNameEditingController =
      new TextEditingController();

  final _bloc = ContactUsdBloc();

  final _formKey = GlobalKey<FormState>();
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
        Translations.of(context).translate('contact_us'),
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
        body: BlocListener<ContactUsdBloc, ContactUsdState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is ContactUsdSuccess) {
              //  ErrorViewer.showCustomError(context,Translations.of(context).translate('msg_contact_us_success'));
              appConfig.showToast(
                  msg: Translations.of(context)
                      .translate('msg_contact_us_success'));
              Get.Get.back();
              // Get.Get.offAllNamed(SignInPage.routeName);
            }
            if (state is ContactUsdFailure) {
              final error = state.error;
              if (error is ConnectionError) {
                ErrorViewer.showConnectionError(context, state.callback);
              } else if (error is CustomError) {
                ErrorViewer.showCustomError(context, error.message);
              } else {
                ErrorViewer.showUnexpectedError(context);
              }
            }
          },
          child: BlocBuilder<ContactUsdBloc, ContactUsdState>(
              bloc: _bloc,
              builder: (context, state) {
                return ModalProgressHUD(
                  inAsyncCall: state is ContactUsdLoading,
                  color: globalColor.primaryColor,
                  opacity: 0.2,
                  child: Container(
                      height: height,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          child: Form(
                            key: _formKey,
                            child: Container(
                              child: Column(
                                children: [
                                  VerticalPadding(
                                    percentage: 2.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: NormalOjosTextFieldWidget(
                                      controller: fullNameEditingController,
                                      // maxLines: 4,
                                      filled: true,
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.black,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        EdgeMargin.small,
                                        EdgeMargin.middle,
                                        EdgeMargin.small,
                                        EdgeMargin.small,
                                      ),
                                      fillColor: globalColor.white,
                                      backgroundColor: globalColor.white,
                                      labelBackgroundColor: globalColor.white,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _fullNameValidation,
                                        );
                                      },
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('full_name'),
                                      keyboardType: TextInputType.text,
                                      borderRadius: width * .02,
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.userSvg,
                                            color: globalColor.black,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          _fullNameValidation = true;
                                          _fullName = value;
                                        });
                                      },
                                      borderColor:
                                          globalColor.grey.withOpacity(0.3),
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 2.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: NormalOjosTextFieldWidget(
                                      controller: phoneEditingController,
                                      // maxLines: 4,
                                      filled: true,
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.black,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        EdgeMargin.small,
                                        EdgeMargin.middle,
                                        EdgeMargin.small,
                                        EdgeMargin.small,
                                      ),
                                      fillColor: globalColor.white,
                                      backgroundColor: globalColor.white,
                                      labelBackgroundColor: globalColor.white,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _phoneValidation,
                                        );
                                      },
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('phone_number'),
                                      keyboardType: TextInputType.phone,
                                      borderRadius: width * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _phoneValidation = true;
                                          _phone = value;
                                        });
                                      },
                                      prefixIcon: Container(
                                        width: 15.w,
                                        height: 15.w,
                                        child: Center(
                                          child: SvgPicture.asset(
                                            AppAssets.phoneSvg,
                                            color: globalColor.black,
                                            width: 15.w,
                                            height: 15.w,
                                          ),
                                        ),
                                      ),
                                      borderColor:
                                          globalColor.grey.withOpacity(0.3),
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 2.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: EdgeMargin.min,
                                        right: EdgeMargin.min),
                                    child: NormalOjosTextFieldWidget(
                                      controller: messageEditingController,
                                      maxLines: 4,
                                      filled: true,
                                      style: textStyle.smallTSBasic.copyWith(
                                          color: globalColor.black,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                        EdgeMargin.small,
                                        EdgeMargin.middle,
                                        EdgeMargin.small,
                                        EdgeMargin.small,
                                      ),
                                      fillColor: globalColor.white,
                                      backgroundColor: globalColor.white,
                                      labelBackgroundColor: globalColor.white,
                                      validator: (value) {
                                        return BaseValidator.validateValue(
                                          context,
                                          value!,
                                          [RequiredValidator()],
                                          _messageValidation,
                                        );
                                      },
                                      hintText: '',
                                      label: Translations.of(context)
                                          .translate('write_your_message'),
                                      keyboardType: TextInputType.text,
                                      borderRadius: width * .02,
                                      onChanged: (value) {
                                        setState(() {
                                          _messageValidation = true;
                                          _message = value;
                                        });
                                      },
                                      borderColor:
                                          globalColor.grey.withOpacity(0.3),
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (_) {
                                        FocusScope.of(context).nextFocus();
                                      },
                                    ),
                                  ),
                                  VerticalPadding(
                                    percentage: 5.0,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: EdgeMargin.min,
                                          right: EdgeMargin.min),
                                      child: RoundedButton(
                                        height: 55.h,
                                        width: width,
                                        color: globalColor.primaryColor,
                                        onPressed: () {
                                          setState(() {
                                            _messageValidation = true;
                                            _phoneValidation = true;
                                            _fullNameValidation = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _bloc.add(
                                              ContactUsdEvent(
                                                phone: _phone,
                                                name: _fullName,
                                                message: _message,
                                                cancelToken: _cancelToken,
                                              ),
                                            );
                                          }
                                        },
                                        borderRadius: 8.w,
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              Translations.of(context)
                                                  .translate('send'),
                                              style: textStyle.middleTSBasic
                                                  .copyWith(
                                                      color: globalColor.white),
                                            ),
                                          ),
                                        ),
                                      )),
                                  VerticalPadding(
                                    percentage: 4.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                );
              }),
        ));
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    _bloc.close();
    super.dispose();
  }
}
