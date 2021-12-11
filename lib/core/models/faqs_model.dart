import 'package:ajb1/core/entities/faqs_entity.dart';
import 'package:ajb1/core/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'faqs_model.g.dart';

@JsonSerializable()
class FaqsModel extends BaseModel<FaqsEntity> {
  final int id;
  final String question;
  final String answer;

  FaqsModel({
    required this.id,
    required this.answer,
    required this.question,
  });

  //
  factory FaqsModel.fromJson(Map<String, dynamic> json) =>
      _$FaqsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqsModelToJson(this);

  @override
  FaqsEntity toEntity() => FaqsEntity(
        id: this.id,
        answer: this.answer,
        question: this.question,
      );
}
