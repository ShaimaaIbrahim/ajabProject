
import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/features/others/data/models/about_app_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'about_app_response.g.dart';

@JsonSerializable()
class AboutAppResponse extends ApiResponse<AboutAppResultModel> {
  AboutAppResponse(
      bool status,
      String msg,
    AboutAppResultModel result,
  ) : super(status, msg, result);

  factory AboutAppResponse.fromJson(Map<String, dynamic> json) =>
      _$AboutAppResponseFromJson(json);
}
