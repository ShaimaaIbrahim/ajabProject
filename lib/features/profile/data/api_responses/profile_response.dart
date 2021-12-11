
import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/features/profile/data/models/profile_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse extends ApiResponse<ProfileModel> {
  ProfileResponse(
      bool status,
      String msg,
      ProfileModel result,
  ) : super(status, msg, result);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
