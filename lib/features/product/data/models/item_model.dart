import 'package:ajb1/core/models/base_model.dart';
import 'package:ajb1/features/product/domin/entities/item_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends BaseModel<ItemEntity> {
  final int id;
  final String name;

  ItemModel({
    required this.id,
    required this.name,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  ItemEntity toEntity() => ItemEntity(
        id: this.id,
        name: this.name,
      );
}
