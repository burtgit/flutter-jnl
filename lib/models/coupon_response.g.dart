// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponResponse _$CouponResponseFromJson(Map<String, dynamic> json) =>
    CouponResponse(
      elmCoupons: (json['elm'] as List<dynamic>)
          .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
          .toList(),
      meituanCoupons: (json['metuan'] as List<dynamic>)
          .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
          .toList(),
      chuxingCoupons: (json['chuxing'] as List<dynamic>)
          .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
          .toList(),
      liveCoupons: (json['live'] as List<dynamic>)
          .map((e) => Coupon.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CouponResponseToJson(CouponResponse instance) =>
    <String, dynamic>{
      'elm': instance.elmCoupons,
      'metuan': instance.meituanCoupons,
      'chuxing': instance.chuxingCoupons,
      'live': instance.liveCoupons,
    };
