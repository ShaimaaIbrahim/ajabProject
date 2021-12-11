import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/features/product/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse extends ApiResponse<List<ProductModel>> {
  ProductResponse(
    bool status,
    String msg,
    List<ProductModel> result,
  ) : super(status, msg, result);

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
}
