import 'package:ajb1/core/models/category_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';


part 'categories_response.g.dart';

@JsonSerializable()
class CategoriesResponse extends ApiResponse<List<CategoryModel>> {
  CategoriesResponse(
    bool status,
    String msg,
    List<CategoryModel> result,
  ) : super(status, msg, result);

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);
}
