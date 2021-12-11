import 'package:ajb1/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

class ImageInfoEntity extends BaseEntity {
  final int id;
  final String productId;
  final String image;

  ImageInfoEntity({
    required this.id,
    required this.productId,
    required this.image,
  });

  @override
  List<Object> get props => [id, image, productId];
}
