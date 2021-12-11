import 'package:ajb1/core/models/offer_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'api_response.dart';

part 'offer_response.g.dart';

@JsonSerializable()
class OfferResponse extends ApiResponse<OfferModel> {
  OfferResponse(
    bool status,
    String msg,
    OfferModel result,
  ) : super(status, msg, result);

  factory OfferResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferResponseFromJson(json);
}
