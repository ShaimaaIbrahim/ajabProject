import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/features/product/data/models/product_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_response.g.dart';

@JsonSerializable()
class ProductDetailsResponse extends ApiResponse<ProductDetailsModel> {
  ProductDetailsResponse(
    bool status,
    String msg,
    ProductDetailsModel result,
  ) : super(status, msg, result);

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);
}
