import 'package:coffee_shop/data/vos/price_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coffee_vo.g.dart';

@JsonSerializable()
class CoffeeVO {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'category')
  final String category;

  @JsonKey(name: 'price')
  final List<PriceVO> price;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'sizes')
  final List<String> sizes;

  @JsonKey(name: 'rating')
  final double rating;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'temperature')
  final List<String> temperature;

  CoffeeVO({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.sizes,
    required this.rating,
    required this.image,
    required this.temperature,
  });

  factory CoffeeVO.fromJson(Map<String, dynamic> json) => _$CoffeeVOFromJson(json);

  Map<String, dynamic> toJson() => _$CoffeeVOToJson(this);

  @override
  String toString() {
    return 'CoffeeVO{id: $id, name: $name, category: $category,}';
  }
}
