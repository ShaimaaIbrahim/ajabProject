import 'package:ajb1/core/models/brand_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';


part 'brands_response.g.dart';

@JsonSerializable()
class BrandsResponse extends ApiResponse<List<BrandModel>> {
  BrandsResponse(
    bool status,
    String msg,
    List<BrandModel> result,
  ) : super(status, msg, result);

  factory BrandsResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandsResponseFromJson(json);
}
