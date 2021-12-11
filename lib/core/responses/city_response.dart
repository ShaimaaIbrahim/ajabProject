import 'package:ajb1/features/order/data/models/city_order_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';

part 'city_response.g.dart';

@JsonSerializable()
class CityResponse extends ApiResponse<List<CityOrderModel>> {
  CityResponse(
    bool status,
    String msg,
    List<CityOrderModel> result,
  ) : super(status, msg, result);

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
}
