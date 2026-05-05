
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coupon_response.dart';

class ApiService {
  static const String apiUrl = 'https://yyapi.sucps.com/index.json';

  static Future<CouponResponse> getCoupons() async {
    try {
      // 添加延迟来更好地展示加载状态
      // await Future.delayed(const Duration(seconds: 2));

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return CouponResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // 模拟数据方法，用于开发测试
  static Future<CouponResponse> getMockCoupons() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(seconds: 1));
    
    const mockData = {
      "elm": [
        {
          "link_name": "饿了么超级会员",
          "app_url": "eleme://i8qEckQTeEXqMAo",
          "h5_url": "https://h5.ele.me/restapi/marketing/promotion/weixin/1234567"
        },
        {
          "link_name": "饿了么新人红包",
          "app_url": "eleme://newuser",
          "h5_url": "https://h5.ele.me/restapi/marketing/promotion/weixin/newuser"
        }
      ],
      "metuan": [
        {
          "link_name": "美团外卖红包",
          "app_url": "imeituan://www.meituan.com/web?url=https://promotion.waimai.meituan.com/lottery/limitskuacttmp/",
          "h5_url": "https://promotion.waimai.meituan.com/lottery/limitskuacttmp/"
        },
        {
          "link_name": "美团会员特权",
          "app_url": "imeituan://www.meituan.com/web?url=https://i.meituan.com/awp/hfe/block/",
          "h5_url": "https://i.meituan.com/awp/hfe/block/"
        }
      ],
      "chuxing": [
        {
          "link_name": "滴滴出行优惠券",
          "app_url": "diditaxi://coupon",
          "h5_url": "https://page.didiglobal.com/global/coupon"
        },
        {
          "link_name": "高德打车红包",
          "app_url": "androidamap://coupon",
          "h5_url": "https://m.amap.com/coupon"
        }
      ],
      "live": [
        {
          "link_name": "肯德基优惠券",
          "app_url": "kfc://coupon",
          "h5_url": "https://www.kfc.com.cn/coupons"
        },
        {
          "link_name": "麦当劳优惠券",
          "app_url": "mcdonalds://coupon",
          "h5_url": "https://www.mcdonalds.com.cn/coupons"
        },
        {
          "link_name": "星巴克优惠券",
          "app_url": "starbucks://coupon",
          "h5_url": "https://www.starbucks.com.cn/coupons"
        }
      ]
    };
    
    return CouponResponse.fromJson(mockData);
  }
}
