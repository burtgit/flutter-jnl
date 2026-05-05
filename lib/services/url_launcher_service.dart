import 'package:url_launcher/url_launcher.dart';
import '../models/coupon.dart';

class UrlLauncherService {
  static Future<bool> launchCouponUrl(Coupon coupon) async {
    // 优先尝试打开app_url（如果存在且不为空）
    if (coupon.appUrl.isNotEmpty) {
      try {
        final appUri = Uri.parse(coupon.appUrl);
        // 尝试启动应用
        final canLaunchApp = await canLaunchUrl(appUri);
        if (canLaunchApp) {
          final success = await launchUrl(
            appUri,
            mode: LaunchMode.externalApplication,
          );
          if (success) {
            return true;
          }
        }
      } catch (e) {
        print('Failed to launch app URL: $e');
      }
    }

    // 如果app_url无法打开或不存在，则尝试打开h5_url
    if (coupon.h5Url.isNotEmpty) {
      try {
        final h5Uri = Uri.parse(coupon.h5Url);
        return await launchUrl(
          h5Uri,
          mode: LaunchMode.externalApplication, // 使用外部浏览器打开
        );
      } catch (e) {
        print('Failed to launch H5 URL: $e');
        return false;
      }
    }

    return false;
  }

  // 专门用于在应用内打开H5链接的方法
  static Future<bool> launchH5InApp(String url) async {
    try {
      final uri = Uri.parse(url);
      return await launchUrl(
        uri,
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      print('Failed to launch H5 URL in app: $e');
      return false;
    }
  }

  // 检查URL是否可以启动
  static Future<bool> canLaunchUrlString(String url) async {
    try {
      if (url.isEmpty) return false;
      final uri = Uri.parse(url);
      return await canLaunchUrl(uri);
    } catch (e) {
      return false;
    }
  }
}
