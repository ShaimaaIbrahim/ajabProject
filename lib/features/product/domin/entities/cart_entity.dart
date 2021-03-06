import 'package:ajb1/core/entities/base_entity.dart';
import 'package:ajb1/features/product/domin/entities/product_details_entity.dart';
import 'package:flutter/foundation.dart';

import 'product_entity.dart';

class CartEntity extends BaseEntity {
  final int id;
  //final int colorId;
  final ProductDetailsEntity productEntity;
  // final LensesSelectedEnum sizeForRightEye;
  // final LensesSelectedEnum sizeForLeftEye;
  // final LensesIpdAddEnum lensSize;
  // final int SizeModeId;
  // // final String ipdSize;
  //  SelectLensesArgs argsForGlasses;
  int count;

  CartEntity({
    required this.id,
    //   @required this.colorId,
    required this.productEntity,
    //  @required this.lensSize,
    //  @required this.sizeForLeftEye,
    //   @required this.sizeForRightEye,
    //   @required this.SizeModeId,
    required this.count,
    //   @required this.argsForGlasses,
  });

  @override
  List<Object> get props => [
        id,
        //  colorId,
        productEntity,
        // lensSize,
        // SizeModeId,
        //     sizeForLeftEye,
        //     sizeForRightEye,
        count,
        //argsForGlasses
      ];
}
