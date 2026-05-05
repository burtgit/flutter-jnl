import 'package:flutter/foundation.dart';
import '../models/coupon_response.dart';
import '../models/coupon.dart';
import '../models/coupon_category.dart';
import 'api_service.dart';

class CouponProvider extends ChangeNotifier {
  CouponResponse? _couponResponse;
  bool _isLoading = false;
  String? _error;

  CouponResponse? get couponResponse => _couponResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Coupon> getCouponsByCategory(CouponCategory category) {
    if (_couponResponse == null) return [];

    switch (category) {
      case CouponCategory.elm:
        return _couponResponse!.elmCoupons;
      case CouponCategory.meituan:
        return _couponResponse!.meituanCoupons;
      case CouponCategory.chuxing:
        return _couponResponse!.chuxingCoupons;
      case CouponCategory.live:
        return _couponResponse!.liveCoupons;
    }
  }

  Future<void> loadCoupons() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // 使用真实API获取数据
      _couponResponse = await ApiService.getCoupons();
    } catch (e) {
      _error = '网络连接失败，请检查网络后重试';
      _couponResponse = null; // 清空数据，不显示模拟数据
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 添加一个专门用于刷新的方法，可以显示不同的加载状态
  Future<void> refreshCoupons() async {
    // 刷新时不显示全屏加载，只显示下拉刷新指示器
    _error = null;
    notifyListeners();

    try {
      _couponResponse = await ApiService.getCoupons();
    } catch (e) {
      _error = '刷新失败，请检查网络连接';
      // 刷新失败时不清空现有数据，保持用户体验
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
