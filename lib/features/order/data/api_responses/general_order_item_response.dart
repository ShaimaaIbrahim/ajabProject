import 'package:ajb1/core/responses/api_response.dart';
import 'package:ajb1/features/order/data/models/general_order_item_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_order_item_response.g.dart';

@JsonSerializable()
class GeneralOrderItemResponse
    extends ApiResponse<List<GeneralOrderItemModel>> {
  GeneralOrderItemResponse(
    bool status,
    String msg,
    List<GeneralOrderItemModel> result,
  ) : super(status, msg, result);

  factory GeneralOrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralOrderItemResponseFromJson(json);
}
