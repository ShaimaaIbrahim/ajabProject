// To parse this JSON data, do
//
//     final generalProductModel = generalProductModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GeneralProductModel generalProductModelFromJson(String str) =>
    GeneralProductModel.fromJson(json.decode(str));

String generalProductModelToJson(GeneralProductModel data) =>
    json.encode(data.toJson());

class GeneralProductModel {
  GeneralProductModel({
    required this.status,
    required this.msg,
    required this.result,
  });

  bool status;
  String msg;
  Result result;

  factory GeneralProductModel.fromJson(Map<String, dynamic> json) =>
      GeneralProductModel(
        status: json["status"],
        msg: json["msg"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "result": result.toJson(),
      };
}

class Result {
  Result({
    required this.adds,
    required this.Weekly_Offers,
    required this.Offers_and_discounts,
    required this.best_seller,
  });

  List<Add> adds;
  List<OffersAndDiscount> Weekly_Offers;
  List<OffersAndDiscount> Offers_and_discounts;
  List<OffersAndDiscount> best_seller;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adds: List<Add>.from(json["adds"].map((x) => Add.fromJson(x))),
        Weekly_Offers: List<OffersAndDiscount>.from(
            json["Weekly_Offers"].map((x) => OffersAndDiscount.fromJson(x))),
        Offers_and_discounts: List<OffersAndDiscount>.from(
            json["Offers_and_discounts"]
                .map((x) => OffersAndDiscount.fromJson(x))),
        best_seller:
            List<OffersAndDiscount>.from(json["best_seller"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "adds": List<dynamic>.from(adds.map((x) => x.toJson())),
        "Weekly_Offers":
            List<dynamic>.from(Weekly_Offers.map((x) => x.toJson())),
        "Offers_and_discounts":
            List<dynamic>.from(Offers_and_discounts.map((x) => x.toJson())),
        "best_seller": List<dynamic>.from(best_seller.map((x) => x)),
      };
}

class Add {
  Add({
    required this.id,
    required this.product_id,
    required this.name,
    required this.discount_type,
    required this.discount_price,
    required this.discount_type_int,
    required this.image,
  });

  int id;
  int product_id;
  String name;
  String discount_type;
  int discount_price;
  int discount_type_int;
  String image;

  factory Add.fromJson(Map<String, dynamic> json) => Add(
        id: json["id"],
        product_id: json["product_id"],
        name: json["name"],
        discount_type: json["discount_type"],
        discount_price: json["discount_price"],
        discount_type_int: json["discount_type_int"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": product_id,
        "name": name,
        "discount_type": discount_type,
        "discount_price": discount_price,
        "discount_type_int": discount_type_int,
        "image": image,
      };
}

class OffersAndDiscount {
  OffersAndDiscount({
    required this.id,
    required this.category_id,
    required this.name,
    required this.price,
    required this.categoryname,
    //required this.price_discount,
    required this.image,
  });

  int id;
  int? category_id;
  String categoryname;
  String name;
  int price;
//double price_discount;
  String image;

  factory OffersAndDiscount.fromJson(Map<String, dynamic> json) =>
      OffersAndDiscount(
        id: json["id"],
        category_id: json["category_id"],
        name: json["name"],
        categoryname: json['categoryname'],
        price: json["price"],
        // price_discount: json["price_discount"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": category_id,
        "name": name,
        "price": price,
        // "price_discount": price_discount,
        "image": image,
      };
}
