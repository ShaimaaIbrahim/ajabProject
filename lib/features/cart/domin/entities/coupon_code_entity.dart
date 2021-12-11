import 'package:ajb1/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

class CouponCodeEntity extends BaseEntity {
  final int? couponId;
  final String? discountAmount;
  final String? discount;
  final String? couponCode;
  final String? total;

  CouponCodeEntity({
    @required this.total,
    @required this.couponCode,
    @required this.couponId,
    @required this.discount,
    @required this.discountAmount,
  });

  @override
  List<Object> get props => [
        total ?? '',
        couponCode ?? 0,
        couponId ?? '',
        discount ?? '',
        discountAmount ?? '',
      ];
}
