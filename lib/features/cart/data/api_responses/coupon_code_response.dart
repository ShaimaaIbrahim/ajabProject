
import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/features/cart/data/models/coupon_code_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coupon_code_response.g.dart';

@JsonSerializable()
class CouponCodeResponse extends ApiResponse<CouponCodeModel> {
  CouponCodeResponse(
      bool status,
      String msg,
      CouponCodeModel result,
  ) : super(status, msg, result);

  factory CouponCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$CouponCodeResponseFromJson(json);
}
