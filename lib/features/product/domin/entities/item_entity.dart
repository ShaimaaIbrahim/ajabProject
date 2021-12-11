import 'package:ajb1/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

class ItemEntity extends BaseEntity {
  final int? id;
  final String? name;

  ItemEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [
        id!,
        name!,
      ];
}
