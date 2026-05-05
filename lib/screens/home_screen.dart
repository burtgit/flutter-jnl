import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/coupon_category.dart';
import '../services/coupon_provider.dart';
import '../widgets/coupon_list_tab.dart';
import '../widgets/customer_service_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // 监听Tab切换（包括滑动和点击）
    _tabController.addListener(() {
      // 实时更新UI以反映滑动过程中的颜色变化
      // 无论是index变化还是offset变化都要更新UI
      setState(() {
        _currentIndex = _tabController.index.round();
      });
    });

    // 延迟添加动画监听器，确保animation已经初始化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tabController.animation?.addListener(() {
        // 在滑动过程中实时更新UI
        if (mounted) {
          setState(() {
            // 这里不需要更新_currentIndex，只需要触发重绘
          });
        }
      });
    });

    // 初始化时加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _getCurrentTabGradient(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text(
              '领券中心',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              tabs: CouponCategory.values.map((category) {
                return Tab(
                  text: category.displayName,
                  icon: _getCategoryIcon(category),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: CouponCategory.values.map((category) {
          return CouponListTab(category: category);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCustomerServiceDialog,
        backgroundColor: _getCurrentTabColor(),
        foregroundColor: Colors.white,
        child: const Icon(Icons.headset_mic),
        tooltip: '联系客服',
      ),
    );
  }

  Color _getCurrentTabColor() {
    // 如果TabController还没有初始化，使用默认颜色
    try {
      if (_tabController.length == 0) {
        return Colors.blue[600]!;
      }
    } catch (e) {
      return Colors.blue[600]!;
    }

    // 获取当前的精确位置（包含小数部分）
    final double position = _tabController.animation?.value ?? _tabController.index.toDouble();

    // 计算当前所在的两个tab之间的位置
    final int leftIndex = position.floor();
    final int rightIndex = position.ceil();
    final double rawProgress = position - leftIndex;

    // 使用增强的进度让颜色变化更早开始
    final double progress = _enhanceProgress(rawProgress);

    // 确保索引在有效范围内
    final int validLeftIndex = leftIndex.clamp(0, CouponCategory.values.length - 1);
    final int validRightIndex = rightIndex.clamp(0, CouponCategory.values.length - 1);

    // 如果在同一个tab上（没有滑动），直接返回该tab的颜色
    if (validLeftIndex == validRightIndex || rawProgress == 0.0) {
      return _getColorForIndex(validLeftIndex);
    }

    // 获取两个tab的颜色并进行插值
    final Color leftColor = _getColorForIndex(validLeftIndex);
    final Color rightColor = _getColorForIndex(validRightIndex);

    return Color.lerp(leftColor, rightColor, progress)!;
  }

  Color _getColorForIndex(int index) {
    final category = CouponCategory.values[index];
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

  void _loadInitialData() async {
    final provider = context.read<CouponProvider>();
    try {
      await provider.loadCoupons();
    } catch (e) {
      // 错误处理已经在provider中完成
    }
  }

  void _showCustomerServiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CustomerServiceDialog(
          themeColor: _getCurrentTabColor(),
          weChatId: 'kaolajiexi2', // 替换为实际的微信号
        );
      },
    );
  }

  Widget _getCategoryIcon(CouponCategory category) {
    IconData iconData;
    switch (category) {
      case CouponCategory.elm:
        iconData = Icons.restaurant;
        break;
      case CouponCategory.meituan:
        iconData = Icons.delivery_dining;
        break;
      case CouponCategory.chuxing:
        iconData = Icons.directions_car;
        break;
      case CouponCategory.live:
        iconData = Icons.local_cafe;
        break;
    }
    return Icon(iconData, size: 20);
  }



  List<Color> _getCurrentTabGradient() {
    // 如果TabController还没有初始化，使用默认颜色
    try {
      if (_tabController.length == 0) {
        return [Colors.blue[400]!, Colors.blue[600]!];
      }
    } catch (e) {
      return [Colors.blue[400]!, Colors.blue[600]!];
    }

    // 获取当前的精确位置（包含小数部分）
    final double position = _tabController.animation?.value ?? _tabController.index.toDouble();

    // 计算当前所在的两个tab之间的位置
    final int leftIndex = position.floor();
    final int rightIndex = position.ceil();
    final double rawProgress = position - leftIndex;

    // 使用更激进的插值曲线，让颜色变化更早开始
    // 当滑动超过20%时就开始明显变化，滑动到80%时基本完成变化
    final double progress = _enhanceProgress(rawProgress);

    // 确保索引在有效范围内
    final int validLeftIndex = leftIndex.clamp(0, CouponCategory.values.length - 1);
    final int validRightIndex = rightIndex.clamp(0, CouponCategory.values.length - 1);

    // 如果在同一个tab上（没有滑动），直接返回该tab的颜色
    if (validLeftIndex == validRightIndex || rawProgress == 0.0) {
      return _getGradientForIndex(validLeftIndex);
    }

    // 获取两个tab的颜色并进行插值
    final List<Color> leftColors = _getGradientForIndex(validLeftIndex);
    final List<Color> rightColors = _getGradientForIndex(validRightIndex);

    return [
      Color.lerp(leftColors[0], rightColors[0], progress)!,
      Color.lerp(leftColors[1], rightColors[1], progress)!,
    ];
  }

  List<Color> _getGradientForIndex(int index) {
    final category = CouponCategory.values[index];
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

  // 增强进度函数，让颜色变化更早开始
  double _enhanceProgress(double progress) {
    if (progress <= 0.0) return 0.0;
    if (progress >= 1.0) return 1.0;

    // 使用三次贝塞尔曲线让变化更早开始
    // 当滑动到30%时，颜色变化就很明显了
    return progress * progress * (3.0 - 2.0 * progress);
  }
}
