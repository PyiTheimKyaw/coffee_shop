// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoffeeVO _$CoffeeVOFromJson(Map<String, dynamic> json) => CoffeeVO(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  price:
      (json['price'] as List<dynamic>)
          .map((e) => PriceVO.fromJson(e as Map<String, dynamic>))
          .toList(),
  description: json['description'] as String,
  sizes: (json['sizes'] as List<dynamic>).map((e) => e as String).toList(),
  rating: (json['rating'] as num).toDouble(),
  image: json['image'] as String,
  temperature:
      (json['temperature'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CoffeeVOToJson(CoffeeVO instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'category': instance.category,
  'price': instance.price,
  'description': instance.description,
  'sizes': instance.sizes,
  'rating': instance.rating,
  'image': instance.image,
  'temperature': instance.temperature,
};
