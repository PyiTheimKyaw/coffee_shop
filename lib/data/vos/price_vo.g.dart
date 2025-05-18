// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceVO _$PriceVOFromJson(Map<String, dynamic> json) =>
    PriceVO(json['size'] as String, (json['amount'] as num).toDouble());

Map<String, dynamic> _$PriceVOToJson(PriceVO instance) => <String, dynamic>{
  'size': instance.size,
  'amount': instance.amount,
};
