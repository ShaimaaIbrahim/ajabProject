import 'package:ajb1/core/models/notifications_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';


part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationsResponse extends ApiResponse<List<NotificationsModel>> {
  NotificationsResponse(
    bool status,
    String msg,
    List<NotificationsModel> result,
  ) : super(status, msg, result);
  //
  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);
}
