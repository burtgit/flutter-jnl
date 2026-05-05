import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/coupon_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CouponApp());
}

class CouponApp extends StatelessWidget {
  const CouponApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CouponProvider(),
      child: MaterialApp(
        title: '领券中心',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


