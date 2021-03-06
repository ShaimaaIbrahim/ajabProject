import 'package:ajb1/core/entities/shipping_carriers_entity.dart';
import 'package:ajb1/core/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'shipping_carriers_model.g.dart';

@JsonSerializable()
class ShippingCarriersModel extends BaseModel<ShippingCarriersEntity> {
  final int id;
  final String name;

  ShippingCarriersModel({required this.id, required this.name});

  factory ShippingCarriersModel.fromJson(Map<String, dynamic> json) =>
      _$ShippingCarriersModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingCarriersModelToJson(this);

  @override
  ShippingCarriersEntity toEntity() => ShippingCarriersEntity(
        id: this.id,
        name: this.name,
      );
}
