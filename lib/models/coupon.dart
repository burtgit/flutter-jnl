import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable()
class Coupon {
  @JsonKey(name: 'link_name')
  final String linkName;
  
  @JsonKey(name: 'app_url')
  final String appUrl;
  
  @JsonKey(name: 'h5_url')
  final String h5Url;

  const Coupon({
    required this.linkName,
    required this.appUrl,
    required this.h5Url,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
