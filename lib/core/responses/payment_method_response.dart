import 'package:ajb1/features/cart/data/models/payment_method_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';


part 'payment_method_response.g.dart';

@JsonSerializable()
class PaymentMethodsResponse extends ApiResponse<List<PaymentMethodModel>> {
  PaymentMethodsResponse(
    bool status,
    String msg,
    List<PaymentMethodModel> result,
  ) : super(status, msg, result);

  factory PaymentMethodsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsResponseFromJson(json);
}
