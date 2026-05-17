# 📋 خطة الاختبار الشاملة لنظام Product و Product Details

## 📌 نظرة عامة

هذا المستند يوضح خطة الاختبار الشاملة لميزة Product و Product Details في تطبيق Product Browser App باستخدام Clean Architecture و BLoC.

---

## 🎯 أهداف الاختبارات

1. **التأكد من صحة منطق العمل (Business Logic)**
2. **التحقق من تدفق الحالات (State Management)**
3. **اختبار تفاعل المستخدم مع الواجهة (UI Interactions)**
4. **التعامل مع جميع الحالات الاستثنائية (Edge Cases)**
5. **ضمان عدم وجود رجوع للانحدار (Regression)**

---

## 📂 هيكل الاختبارات

```
test/
├── features/
│   ├── product/
│   │   ├── data/
│   │   │   ├── product_web_services_test.dart      (اختبار API)
│   │   │   └── product_repository_test.dart         (اختبار Repository)
│   │   ├── bloc/
│   │   │   └── product_bloc_test.dart               (اختبار BLoC)
│   │   └── view/
│   │       └── product_list_screen_test.dart        (اختبار الواجهة)
│   └── product_detail/
│       ├── data/
│       │   ├── product_detail_web_service_test.dart (اختبار API)
│       │   └── product_detail_repository_test.dart  (اختبار Repository)
│       ├── bloc/
│       │   └── product_detail_bloc_test.dart        (اختبار BLoC)
│       └── view/
│           └── product_detail_screen_test.dart      (اختبار الواجهة)
├── integration_tests_helpers.dart                    (اختبارات تكاملية)
└── TEST_PLAN.md                                      (هذا الملف)
```

---

## 🧪 تفاصيل الاختبارات

### 1️⃣ Unit Tests - Data Layer

#### **product_web_services_test.dart**
الغرض: اختبار API calls والتأكد من معالجة البيانات بشكل صحيح

**المجموعات:**
- ✅ **Success Cases**: اختبار نجاح الاتصال وتحويل البيانات
- ⚠️ **Error Cases**: اختبار معالجة الأخطاء (404, 500, Network errors)
- 🔄 **Edge Cases**: اختبار الحالات الحدية (فئات فارغة، عدد كبير من المنتجات)

**مثال من الاختبارات:**
```dart
test('يجب أن يعيد ProductResponse عند نجاح الاتصال', () async { ... })
test('يجب أن ترمي استثناء عند حالة 404', () async { ... })
test('يجب أن يتعامل مع قائمة فارغة من المنتجات', () async { ... })
```

#### **product_repository_test.dart**
الغرض: اختبار منطق Repository والتأكد من عدم تعديل البيانات

**المجموعات:**
- ✅ **Success Cases**: التحقق من إعادة البيانات الصحيحة
- 🛡️ **Data Integrity**: التأكد من عدم تعديل البيانات
- 🔄 **Multiple Categories**: اختبار مع فئات مختلفة

---

### 2️⃣ Unit Tests - BLoC Layer

#### **product_bloc_test.dart**
الغرض: اختبار تدفق الحالات ومعالجة الأحداث

**الأحداث المختبرة:**
1. **LoadByCategory Event**
   - ✅ ينبعث [Loading, Loaded] عند النجاح
   - ❌ ينبعث [Loading, Error] عند الفشل
   - 📊 يتعامل مع القائمة الفارغة

2. **Search Event**
   - 🔍 يصفي المنتجات حسب الكلمة المفتاحية
   - 🔤 غير حساس لحالة الأحرف (LAPTOP == laptop)
   - ♻️ يعيد جميع المنتجات عند حذف البحث
   - 🚫 يعود بقائمة فارغة إذا لم توجد نتائج

**مثال:**
```dart
blocTest('يجب أن ينبعث [Loading, Loaded] عند نجاح تحميل المنتجات',
  build: () { ... },
  act: (bloc) => bloc.add(ProductEvent.loadByCategory('electronics')),
  expect: () => [
    const ProductState.loading(),
    ProductState.loaded(...),
  ]
)
```

#### **product_detail_bloc_test.dart**
الغرض: اختبار بلوك تفاصيل المنتج

**الأحداث:**
1. **FetchProductDetailEvent**
   - ✅ ينبعث [Loading, Loaded] عند النجاح
   - 📝 يحتفظ بجميع بيانات المنتج
   - 🖼️ يتعامل مع المنتجات بدون صور
   - ⭐ يتعامل مع المنتجات بدون تقييمات

---

### 3️⃣ Widget Tests - Presentation Layer

#### **product_list_screen_test.dart**
الغرض: اختبار واجهة قائمة المنتجات

**الاختبارات:**
| الاختبار | الهدف |
|---------|-------|
| Loading State | عرض CircularProgressIndicator |
| Loaded State | عرض قائمة المنتجات في GridView |
| Error State | عرض رسالة خطأ |
| Empty State | التعامل مع قائمة فارغة |
| AppBar Tests | التحقق من وجود AppBar واسم الفئة |
| State Transitions | انتقالات الحالات |

**مثال:**
```dart
testWidgets('يجب أن يعرض قائمة الم��تجات عند نجاح التحميل', (tester) async {
  whenListen(mockBloc, Stream.fromIterable([ProductState.loaded(...)]));
  await tester.pumpWidget(createWidgetUnderTest());
  expect(find.byType(GridView), findsOneWidget);
})
```

#### **product_detail_screen_test.dart**
الغرض: اختبار واجهة تفاصيل المنتج

**الاختبارات الرئيسية:**
- 📊 **Loading**: عرض الـ Loader
- ✅ **Loaded**: عرض جميع البيانات والـ BottomBar
- ❌ **Error**: عرض رسالة الخطأ
- 🔄 **State Transitions**: انتقالات سلسة

---

## 🛠️ أدوات الاختبار المستخدمة

### المكتبات المستخدمة:
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^10.0.0        # اختبار BLoC
  mocktail: ^1.0.5          # Mocking
```

### أنماط الاختبار:
1. **AAA Pattern (Arrange-Act-Assert)**
   ```dart
   // Arrange - التحضير
   when(...).thenAnswer(...)
   
   // Act - التنفيذ
   await repository.getProducts(...)
   
   // Assert - التحقق
   expect(result, ...)
   ```

2. **BDD Pattern (Given-When-Then)**
   ```dart
   // Given - معطيات
   final products = [...]
   
   // When - عند حدوث
   bloc.add(LoadByCategory(...))
   
   // Then - النتيجة
   expect(state, equals(ProductState.loaded(...)))
   ```

---

## 📈 تغطية الاختبارات

### النسب المستهدفة:
- **Data Layer**: 95%+ تغطية
- **BLoC Layer**: 90%+ تغطية
- **Widget Tests**: 85%+ تغطية

### المقاييس:
```
Lines Tested        : XX%
Branches Tested     : XX%
Functions Tested    : XX%
Statements Tested   : XX%
```

---

## ⚠️ الحالات الحدية المختبرة

### Data Layer Edge Cases:
- ✅ قوائم فارغة
- ✅ عدد كبير من العناصر (100+)
- ✅ عناصر بدون حقول اختيارية
- ✅ أسماء فئات بمسافات وأحرف كبيرة
- ✅ معرفات منتجات صفر وغير صحيحة

### BLoC Layer Edge Cases:
- ✅ البحث عن كلمات غير موجودة
- ✅ البحث بدون حالة loaded
- ✅ انتقالات حالات متعددة
- ✅ أخطاء متزامنة

### Widget Layer Edge Cases:
- ✅ انتقالات بطيئة من loading إلى loaded
- ✅ أخطاء أثناء التفاعل
- ✅ إعادة بناء الواجهة

---

## 🚀 كيفية تشغيل الاختبارات

### تشغيل جميع الاختبارات:
```bash
flutter test
```

### تشغيل اختبارات محددة:
```bash
# اختبارات المنتجات فقط
flutter test test/features/product/

# اختبارات BLoC فقط
flutter test test/features/product/bloc/

# اختبار واحد فقط
flutter test test/features/product/data/product_web_services_test.dart
```

### مع التغطية:
```bash
flutter test --coverage
```

---

## 📊 قائمة الاختبارات الكاملة

### Product Web Services (18 اختبار)
- 5 اختبارات نجاح
- 5 اختبارات أخطاء
- 8 اختبارات حدية

### Product Repository (13 اختبار)
- 4 اختبارات نجاح
- 4 اختبارا�� أخطاء
- 5 اختبارات تكامل البيانات

### Product Detail Web Service (17 اختبار)
- 5 اختبارات نجاح
- 6 اختبارات أخطاء
- 6 اختبارات حدية

### Product Detail Repository (14 اختبار)
- 5 اختبارات نجاح
- 5 اختبارات أخطاء
- 4 اختبارات تكامل البيانات

### Product BLoC (24 اختبار)
- 5 اختبارات LoadByCategory
- 9 اختبارات Search
- 10 اختبارات حدية

### Product Detail BLoC (19 اختبار)
- 8 اختبارات FetchProductDetail
- 4 اختبارات انتقالات
- 7 اختبارات حدية

### Product List Screen (16 اختبار)
- 4 اختبارات Loading
- 3 اختبارات Loaded
- 3 اختبارات Error
- 6 اختبارات تفاعل

### Product Detail Screen (18 اختبار)
- 3 اختبارات Loading
- 4 اختبارات Loaded
- 3 اختبارات Error
- 8 اختبارات بنية وتفاعل

---

## ✅ معايير النجاح

الاختبار يعتبر **نجح** إذا:
1. ✅ جميع الـ assertions صحيحة
2. ✅ الكود يعمل بدون warnings
3. ✅ الأداء مقبول (< 100ms لكل اختبار)
4. ✅ لا توجد memory leaks

---

## 📝 ملاحظات مهمة

### استخدام Mocking:
- **mocktail** لـ mocking الـ Repository و WebService
- **bloc_test** لـ mocking BLoC
- **flutter_test** للـ UI tests

### Best Practices:
1. ✅ استخدام AAA Pattern
2. ✅ اختبار التشفير الصحيح (UTF-8) للنصوص العربية
3. ✅ استخدام `setUp` و `tearDown` بشكل صحيح
4. ✅ عدم الاعتماد على الأوقات الحقيقية
5. ✅ مسح الـ BLoC بعد الاختبار

### الأخطاء الشائعة:
❌ الاعتماد على بيانات حقيقية من API  
❌ عدم إغلاق الـ BLoC  
❌ اختبار قطع شبكة حقيقية  
❌ استخدام `wait()` بدون `pumpAndSettle()`  

---

## 🔗 الملفات ذات الصلة

- `lib/features/product/bloc/product_bloc.dart` - منطق المنتجات
- `lib/features/product_detail/bloc/product_detail_bloc.dart` - تفاصيل المنتج
- `lib/features/product/data/product_repository.dart` - بيانات المنتجات
- `lib/features/product/view/product_screen.dart` - واجهة المنتجات

---

## 📈 الخطوات التالية

1. تشغيل جميع الاختبارات والتأكد من نجاحها
2. قياس نسبة التغطية
3. إضافة المزيد من الاختبارات حسب الحاجة
4. تحديث الاختبارات عند تعديل الكود

---

**آخر تحديث:** May 8, 2026  
**الإصدار:** 1.0.0  
**الحالة:** ✅ كامل و منتج

