import 'package:ajb1/core/entities/faqs_entity.dart';
import 'package:ajb1/core/res/screen/screen_helper.dart';
import 'package:ajb1/core/ui/list/build_list_faqs.dart';
import 'package:ajb1/features/others/data/models/questions_answers_model.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class QuestionsAnswersPage extends StatefulWidget {
  static const routeName = '/others/sub_pages/pages/QuestionsAnswersPage';

  @override
  _QuestionsAnswersPageState createState() => _QuestionsAnswersPageState();
}

class _QuestionsAnswersPageState extends State<QuestionsAnswersPage> {
  List<QuestionsAnswersModel>? _listQ;

  initList() {
    _listQ = [
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'ما الذي يميز أوجوس ؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'ما هي قيمة الخدمة ؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'كيف أدفع ؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'ما العمل اذا واجهتني مشكلة ؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'من هم أوجوس ؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'ايش اقدر اطلب من أوجوس؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'متى أقدر أطلب؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'كيف اتابع العروض التي تنزل بشكل يومي ؟'),
      QuestionsAnswersModel(
          answer:
              'شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني  تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها شريت هذي النظارة وما شاء الله انيقة كثير ومرة عجبتني تشتروها والخدمة مرة ممتازة وصلتني خلال يوم فقط شكرا لكم شريت هذي النظارة وما شاء الله انيقة كثير تشتروها ',
          question: 'ما هي الأقسام المتوفرة في أوجوس ؟'),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _cancelToken = CancelToken();

  @override
  Widget build(BuildContext context) {
    initList();
    //=========================================================================

    AppBar appBar = AppBar(
      backgroundColor: globalColor.appBar,
      brightness: Brightness.light,
      elevation: 0,
      leading: ArrowIconButtonWidget(
        iconColor: globalColor.black,
      ),
      title: Text(
        Translations.of(context).translate('questions_and_answers'),
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
                padding: const EdgeInsets.only(
                    left: EdgeMargin.min, right: EdgeMargin.min),
                child: Column(
                  children: [
                    VerticalPadding(
                      percentage: 2.0,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: globalColor.white,
                          borderRadius: BorderRadius.all(Radius.circular(12.w)),
                          // border:
                          // Border.all(color: globalColor.primaryColor.withOpacity(0.3), width: 0.5),
                        ),
                        child: BuildListFaqsWidget(
                          itemWidth: width,
                          params: {},
                          cancelToken: _cancelToken,
                          isEnableRefresh: false,
                          isEnablePagination: false,
                          isScrollList: false,
                        )),
                    VerticalPadding(
                      percentage: 4.0,
                    ),
                  ],
                ),
              ),
            )));
  }

  @override
  void dispose() {
    _cancelToken.cancel();
    super.dispose();
  }
}

class QuestionsAnswersItemWidget extends StatefulWidget {
  final FaqsEntity questionsAnswers;
  final double? width;

  const QuestionsAnswersItemWidget(
      {required this.questionsAnswers, required this.width});

  @override
  _QuestionsAnswersItemWidgetState createState() =>
      _QuestionsAnswersItemWidgetState();
}

class _QuestionsAnswersItemWidgetState
    extends State<QuestionsAnswersItemWidget> {
  String? _text;
  Color? _color;

  bool? sendRequest;
  bool? isSuccessRequest;
  bool? isFoundPhoneNumber;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? ScreensHelper.fromWidth(85);
    return Container(
      width: width,

      //   margin: const EdgeInsets.only(left: EdgeMargin.verySub,),
      child: ExpandableNotifier(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Builder(builder: (context) {
              var exp = ExpandableController.of(context);
              return InkWell(
                hoverColor: globalColor.transparent,
                splashColor: globalColor.transparent,
                highlightColor: globalColor.transparent,
                onTap: () {
                  exp!.toggle();
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(
                    EdgeMargin.min,
                    EdgeMargin.normal,
                    EdgeMargin.min,
                    EdgeMargin.normal,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.questionsAnswers.question ?? '',
                              style: textStyle.minTSBasic.copyWith(
                                  color: exp!.expanded
                                      ? globalColor.primaryColor
                                      : globalColor.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        exp.expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 25.w,
                        color: exp.expanded
                            ? globalColor.primaryColor
                            : globalColor.grey,
                      ),
                    ],
                  ),
                ),
              );
            }),
            Expandable(
              collapsed: buildCollapsed3(),
              expanded: buildExpanded3(),
            ),
          ],
        ),
      ),
    );
  }

  /// for service details
  buildExpanded3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Divider(
          height: 1.5,
          color: globalColor.grey.withOpacity(0.3),
          thickness: .8,
        ),
        Container(
          padding: const EdgeInsets.all(EdgeMargin.min),
          child: Text(
            "${widget.questionsAnswers.answer ?? ''}",
            softWrap: true,
            style: textStyle.minTSBasic.copyWith(
                color: globalColor.black, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  buildCollapsed3() {
    return Container();
  }
}
