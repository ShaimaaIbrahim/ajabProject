import 'package:ajb1/core/repositories/core_repository.dart';
import 'package:ajb1/core/usecases/contact_us.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
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

abstract class ContactUsdState extends Equatable {}

class ContactUsdUninitialized extends ContactUsdState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ContactUsdUninitialized';
}

class ContactUsdLoading extends ContactUsdState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ContactUsdLoading';
}

class ContactUsdSuccess extends ContactUsdState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'ContactUsdSuccess';
}

class ContactUsdFailure extends ContactUsdState {
  final BaseError error;
  final VoidCallback? callback;

  ContactUsdFailure({
    required this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [error, callback!];

  @override
  String toString() => 'ContactUsdFailure { error: $error }';
}

abstract class BaseContactUsdEvent extends Equatable {}

class ContactUsdEvent extends BaseContactUsdEvent {
  final String? name;
  final String? phone;
  final String? message;
  final CancelToken? cancelToken;

  ContactUsdEvent({
    this.name,
    this.message,
    this.phone,
    this.cancelToken,
  });

  @override
  List<Object> get props => [
        name ?? '',
        cancelToken ?? '',
        message ?? '',
        phone ?? '',
      ];

  @override
  String toString() => 'ContactUsdEvent';
}

class ContactUsdBloc extends Bloc<BaseContactUsdEvent, ContactUsdState> {
  ContactUsdBloc() : super(ContactUsdUninitialized());

  @override
  Stream<ContactUsdState> mapEventToState(BaseContactUsdEvent event) async* {
    if (event is ContactUsdEvent) {
      yield ContactUsdLoading();
      final result = await ContactUsUseCase(locator<CoreRepository>())(
        ContactUsParams(
          message: event.message!,
          name: event.name!,
          phone: event.phone!,
          cancelToken: event.cancelToken!,
        ),
      );
      if (result.hasDataOnly) {
        yield ContactUsdSuccess();
      }
      if (result.hasErrorOnly) {
        yield ContactUsdFailure(
          error: result.error!,
          callback: () {
            this.add(event);
          },
        );
      }
    }
  }
}
