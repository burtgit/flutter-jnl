import 'package:json_annotation/json_annotation.dart';
import 'coupon.dart';

part 'coupon_response.g.dart';

@JsonSerializable()
class CouponResponse {
  @JsonKey(name: 'elm')
  final List<Coupon> elmCoupons;

  @JsonKey(name: 'metuan')
  final List<Coupon> meituanCoupons;

  @JsonKey(name: 'chuxing')
  final List<Coupon> chuxingCoupons;

  @JsonKey(name: 'live')
  final List<Coupon> liveCoupons;

  const CouponResponse({
    required this.elmCoupons,
    required this.meituanCoupons,
    required this.chuxingCoupons,
    required this.liveCoupons,
  });

  factory CouponResponse.fromJson(Map<String, dynamic> json) => _$CouponResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CouponResponseToJson(this);
}
