import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coupon_category.dart';
import '../services/coupon_provider.dart';
import 'coupon_card.dart';

class CouponListTab extends StatelessWidget {
  final CouponCategory category;

  const CouponListTab({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CouponProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_getRefreshIndicatorColor()),
                ),
                const SizedBox(height: 16),
                Text(
                  '正在获取${category.displayName}优惠券...',
                  style: TextStyle(
                    fontSize: 16,
                    color: _getRefreshIndicatorColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '请稍候',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        if (provider.error != null) {
          return RefreshIndicator(
            onRefresh: () {
              provider.clearError();
              return provider.refreshCoupons();
            },
            color: _getRefreshIndicatorColor(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '加载失败',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Text(
                            provider.error!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            provider.clearError();
                            provider.loadCoupons();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _getRefreshIndicatorColor(),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('重试'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '或下拉刷新',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final coupons = provider.getCouponsByCategory(category);

        // 如果没有数据且不在加载状态，显示获取数据的提示
        if (provider.couponResponse == null && !provider.isLoading) {
          return RefreshIndicator(
            onRefresh: () => provider.refreshCoupons(),
            color: _getRefreshIndicatorColor(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_download_outlined,
                          size: 64,
                          color: _getRefreshIndicatorColor().withOpacity(0.6),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '暂未获取到${category.displayName}数据',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '下拉刷新获取最新优惠券',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (coupons.isEmpty) {
          return RefreshIndicator(
            onRefresh: () => provider.refreshCoupons(),
            color: _getRefreshIndicatorColor(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '暂无${category.displayName}优惠券',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '下拉刷新试试',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => provider.loadCoupons(),
          color: _getRefreshIndicatorColor(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              return CouponCard(
                coupon: coupons[index],
                category: category,
              );
            },
          ),
        );
      },
    );
  }

  Color _getRefreshIndicatorColor() {
    switch (category) {
      case CouponCategory.elm:
        return Colors.blue[600]!;
      case CouponCategory.meituan:
        return Colors.orange[600]!;
      case CouponCategory.chuxing:
        return Colors.green[600]!;
      case CouponCategory.live:
        return Colors.purple[600]!;
    }
  }
}
