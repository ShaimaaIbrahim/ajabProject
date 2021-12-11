import 'package:ajb1/features/product/domin/entities/product_entity.dart';

class SectionArgsHome {
  final List<ProductEntity>? list;
  final String? name;
  final int? id;

  const SectionArgsHome({this.name, this.id, this.list});
}
