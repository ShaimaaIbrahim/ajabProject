import 'package:ajb1/core/models/faqs_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';


part 'faqs_response.g.dart';

@JsonSerializable()
class FaqsResponse extends ApiResponse<List<FaqsModel>> {
  FaqsResponse(
    bool status,
    String msg,
    List<FaqsModel> result,
  ) : super(status, msg, result);
  //
  factory FaqsResponse.fromJson(Map<String, dynamic> json) =>
      _$FaqsResponseFromJson(json);
}
