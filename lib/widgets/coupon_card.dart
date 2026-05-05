import 'package:flutter/material.dart';
import '../models/coupon.dart';
import '../models/coupon_category.dart';
import '../services/url_launcher_service.dart';

class CouponCard extends StatelessWidget {
  final Coupon coupon;
  final CouponCategory category;

  const CouponCard({
    super.key,
    required this.coupon,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => _launchCoupon(context),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: _getGradientColors(),
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(
                    _getCategoryIcon(),
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coupon.linkName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '点击领取${category.displayName}优惠券',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '领取',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Color> _getGradientColors() {
    switch (category) {
      case CouponCategory.elm:
        return [Colors.blue[400]!, Colors.blue[600]!];
      case CouponCategory.meituan:
        return [Colors.orange[400]!, Colors.orange[600]!];
      case CouponCategory.chuxing:
        return [Colors.green[400]!, Colors.green[600]!];
      case CouponCategory.live:
        return [Colors.purple[400]!, Colors.purple[600]!];
    }
  }

  IconData _getCategoryIcon() {
    switch (category) {
      case CouponCategory.elm:
        return Icons.restaurant;
      case CouponCategory.meituan:
        return Icons.delivery_dining;
      case CouponCategory.chuxing:
        return Icons.directions_car;
      case CouponCategory.live:
        return Icons.local_cafe;
    }
  }

  Future<void> _launchCoupon(BuildContext context) async {
    // 显示加载提示
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Text('正在打开${coupon.linkName}...'),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: _getGradientColors()[1],
        ),
      );
    }

    try {
      final success = await UrlLauncherService.launchCouponUrl(coupon);
      if (!success && context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('无法打开链接，请检查网络连接或相关应用是否已安装'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      } else if (context.mounted) {
        // 成功打开链接，隐藏加载提示
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('打开链接失败: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}
