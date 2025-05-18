import 'package:json_annotation/json_annotation.dart';

part 'price_vo.g.dart';

@JsonSerializable()
class PriceVO {
  @JsonKey(name: 'size')
  final String size;
  @JsonKey(name: 'amount')
  final double amount;

  PriceVO(this.size, this.amount);

  factory PriceVO.fromJson(Map<String, dynamic> json) => _$PriceVOFromJson(json);

  Map<String, dynamic> toJson() => _$PriceVOToJson(this);
}
