
import 'package:ajb1/core/models/base_model.dart';
import 'package:ajb1/features/profile/domin/entities/profile_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends BaseModel<ProfileEntity> {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String address;
  final String phone;
  @JsonKey(name: 'about_me')
  final String aboutMe;
  //final bool notify_new_product;
  //final bool notify_wallet;
  //final bool notify_offer;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.aboutMe,
    required this.photo,
    required this.phone,
    //  required this.notify_new_product,
    // required this.notify_offer,
    //required this.notify_wallet,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  @override
  ProfileEntity toEntity() => ProfileEntity(
      id: this.id,
      email: this.email,
      address: this.address,
      about_me: this.aboutMe,
      phone: this.phone,
      name: this.name,
      photo: this.photo);
  //  notify_new_product: this.notify_new_product,
  // notify_offer: this.notify_offer,
  //notify_wallet: this.notify_wallet);
}
