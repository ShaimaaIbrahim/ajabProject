import 'package:ajb1/core/models/base_model.dart';
import 'package:ajb1/features/product/domin/entities/general_item_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_item_model.g.dart';

@JsonSerializable()
class GeneralItemModel extends BaseModel<GeneralItemEntity> {
  final int id;
  final String name;
  final String value;
  final String image;

  GeneralItemModel({
    required this.id,
    required this.name,
    required this.value,
    required this.image,
  });

  factory GeneralItemModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralItemModelToJson(this);

  @override
  GeneralItemEntity toEntity() => GeneralItemEntity(
        id: this.id,
        name: this.name,
        image: this.image,
        value: this.value,
      );
}