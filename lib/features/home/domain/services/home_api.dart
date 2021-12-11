import 'dart:async';

import 'package:ajb1/core/constants.dart';
import 'package:ajb1/features/home/domain/model/category_model.dart';
import 'package:ajb1/features/home/domain/model/product_model.dart';
import 'package:dio/dio.dart';


Dio dio = Dio();

class HomePageApi {
  StreamController? productController;

  Future<GeneralProductModel>? feachProduct(int categoryId) async {
    Response response = await dio.get(productUrl(categoryId));
    if (response.statusCode == 200) {
      return GeneralProductModel.fromJson(response.data);
    } else {
      return GeneralProductModel.fromJson({});
    }
  }

  // loadProductStream(id) {
  //   feachProduct(id)!.then((res) async {
  //     productController!.add(res);
  //     return res;
  //   });
  // }

  Future<GeneralCategoryModel?>? feachCategory() async {
    Response response = await dio.get(categoryUrl);
    if (response.statusCode == 200) {
      return GeneralCategoryModel.fromJson(response.data);
    }
    return GeneralCategoryModel.fromJson({});
  }
}
