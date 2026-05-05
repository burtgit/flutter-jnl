// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dnl/services/coupon_provider.dart';
import 'package:dnl/screens/home_screen.dart';

void main() {
  testWidgets('App loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => CouponProvider(),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    // Verify that the app title is displayed.
    expect(find.text('领券中心'), findsOneWidget);

    // Verify that the tabs are displayed.
    expect(find.text('饿了么'), findsOneWidget);
    expect(find.text('美团'), findsOneWidget);
    expect(find.text('其他出行'), findsOneWidget);
  });
}
