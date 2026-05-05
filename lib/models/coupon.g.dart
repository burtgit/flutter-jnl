// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coupon _$CouponFromJson(Map<String, dynamic> json) => Coupon(
      linkName: json['link_name'] as String,
      appUrl: json['app_url'] as String,
      h5Url: json['h5_url'] as String,
    );

Map<String, dynamic> _$CouponToJson(Coupon instance) => <String, dynamic>{
      'link_name': instance.linkName,
      'app_url': instance.appUrl,
      'h5_url': instance.h5Url,
    };
