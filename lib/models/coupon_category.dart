enum CouponCategory {
  elm('饿了么', 'elm'),
  meituan('美团', 'meituan'),
  chuxing('其他出行', 'chuxing'),
  live('生活服务', 'live');

  const CouponCategory(this.displayName, this.key);

  final String displayName;
  final String key;
}
