import 'package:ajb1/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

import 'general_item_entity.dart';
import 'image_info_entity.dart';
import 'item_entity.dart';

class ProductEntity extends BaseEntity {
  final int? id;
  final int? category_id;
  final String? name;
  int? price;
  final int? quantity;
  final String? discount_type;
  final int? discount_price;
  final String? image;
  final bool? is_new;
  final String? description;
  final String? rate;
  final bool? isReview;
  final bool? isFavorite;
  final int? review_count;
  List<ProductEntity>? product_as_same;

  ProductEntity({
    required this.category_id,
    required this.name,
    required this.id,
    required this.price,
    required this.description,
    this.is_new,
    required this.rate,
    required this.image,
    this.quantity,
    required this.discount_price,
    this.discount_type,
    this.isReview,
    this.product_as_same,
    this.review_count,
    required this.isFavorite,
  });

  @override
  List<Object> get props => [];
}
