import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_browser_app/app_router.dart';
import 'package:product_browser_app/core/di/injection_container.dart';
import 'package:product_browser_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    // تهيئة SharedPreferences وهمي قبل تشغيل الـ Injection
    SharedPreferences.setMockInitialValues({});

    // ملاحظة: بما أن التطبيق يعتمد على Firebase، يجب عمل Mock له أو التأكد من تهيئة GetIt
    // بشكل لا يعتمد على اتصال حقيقي في بيئة التست.
    await initGetIt();
  });

  testWidgets('التأكد من تشغيل التطبيق بنجاح (Smoke Test)', (
    WidgetTester tester,
  ) async {
    // بناء التطبيق وتحريك أول فريم
    await tester.pumpWidget(ProductBrowserApp(appRouter: AppRouter()));

    // التحقق من وجود واجهة تسجيل الدخول (كحالة أولية لغير المسجلين)
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
