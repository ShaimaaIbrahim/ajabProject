import 'package:ajb1/core/entities/base_entity.dart';
import 'package:flutter/foundation.dart';

class ForgetResult extends BaseEntity {
  final String otp_code;

  // final String msg;

  ForgetResult({
    required this.otp_code,
  });

  @override
  List<Object> get props => [
        otp_code,
      ];
}
