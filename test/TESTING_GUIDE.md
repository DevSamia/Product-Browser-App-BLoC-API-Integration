# اختبارات التطبيق (Testing Guide)

هذا الملف يشرح الاختبارات الشاملة المكتوبة للتطبيق بناءً على معمارية Clean Architecture و بنمط BLoC.

## 📦 المكتبات المستخدمة

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.7
  mocktail: ^1.0.3
```

## 🗂️ هيكل الاختبارات

```
test/
├── features/
│   ├── auth/
│   │   ├── bloc/
│   │   │   └── auth_bloc_test.dart
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_usecase_test.dart
│   │   └── view/
│   │       └── login_screen_widget_test.dart
│   └── chat/
│       ├── domain/
│       │   └── usecases/
│       │       ├── send_message_usecase_test.dart
│       │       └── watch_messages_usecase_test.dart
│       └── presentation/
│           ├── bloc/
│           │   └── chat_bloc_test.dart
│           └── screens/
│               └── chat_screen_widget_test.dart
```

## 🧪 أنواع الاختبارات

### 1. Unit Tests (اختبارات الوحدة)

#### LoginUseCase Tests
**الملف:** `test/features/auth/domain/usecases/login_usecase_test.dart`

**الاختبارات:**
- ✅ تسجيل دخول ناجح
- ❌ بيانات خاطئة
- ❌ بريد إلكتروني فارغ
- ❌ كلمة مرور فارغة
- ❌ أخطاء الشبكة
- ✅ التحقق من معاملات الدالة

**المثال:**
```dart
test('should return AppUser when login is successful', () async {
  // Arrange
  when(() => mockAuthRepository.login(testEmail, testPassword))
      .thenAnswer((_) async => testUser);

  // Act
  final result = await loginUseCase.execute(testEmail, testPassword);

  // Assert
  expect(result, equals(testUser));
});
```

#### SendMessageUseCase Tests
**الملف:** `test/features/chat/domain/usecases/send_message_usecase_test.dart`

**الاختبارات:**
- ✅ إرسال الرسالة بنجاح
- ❌ معالجة رسائل فارغة
- ❌ معالجة معرف المنتج الفارغ
- ❌ أخطاء الاتصال بـ Firestore
- ✅ معالجة النصوص الطويلة
- ✅ معالجة الأحرف الخاصة والـ Unicode

#### WatchMessagesUseCase Tests
**الملف:** `test/features/chat/domain/usecases/watch_messages_usecase_test.dart`

**الاختبارات:**
- ✅ بث الرسائل من الـ Repository
- ✅ قائمة الرسائل الفارغة
- ✅ تحديثات متعددة للرسائل
- ❌ معالجة أخطاء البث
- ✅ الحفاظ على ترتيب الرسائل
- ✅ التعامل مع عدد كبير من الرسائل

### 2. BLoC Tests (اختبارات الـ Business Logic)

#### AuthBloc Tests
**الملف:** `test/features/auth/bloc/auth_bloc_test.dart`

**الأحداث والحالات المختبرة:**

1. **LoginRequested:**
   ```dart
   blocTest<AuthBloc, AuthState>(
     'emits [AuthLoading, AuthAuthenticated] when login is successful',
     setUp: () { /* تحضير البيانات */ },
     build: () => authBloc,
     act: (bloc) => bloc.add(const AuthEvent.loginRequested(...)),
     expect: () => [
       const AuthState.loading(),
       AuthState.authenticated(testUser),
     ],
   );
   ```

2. **RegisterRequested:** تسجيل مستخدم جديد
3. **LogoutRequested:** تسجيل الخروج
4. **AuthCheckRequested:** التحقق من وجود جلسة نشطة
5. **GoogleSignInRequested:** تسجيل الدخول عبر Google
6. **ProfileUpdateRequested:** تحديث الملف الشخصي
7. **PasswordResetRequested:** إعادة تعيين كلمة المرور

#### ChatBloc Tests
**الملف:** `test/features/chat/presentation/bloc/chat_bloc_test.dart`

**الأحداث والحالات المختبرة:**

1. **WatchMessagesEvent:**
   - بث الرسائل الحية
   - قائمة رسائل فارغة
   - معالجة أخطاء البث
   - إلغاء الاشتراك السابق

2. **SendMessageEvent:**
   - إرسال الرسالة بنجاح
   - عدم إرسال الرسائل الفارغة
   - معالجة الأسماء المُنشأة عشوائياً

3. **MessagesUpdatedEvent:**
   - تحديث الحالة مع رسائل جديدة

### 3. Widget Tests (اختبارات الواجهات)

#### LoginScreen Widget Tests
**الملف:** `test/features/auth/view/login_screen_widget_test.dart`

**الاختبارات:**
- ✅ عرض الشعار
- ✅ عرض نصوص الترحيب
- ✅ عرض مؤشر التحميل أثناء الانتظار
- ✅ عرض نموذج تسجيل الدخول في الحالة الأولية
- ✅ عرض رسالة الخطأ عند الفشل
- ✅ عرض زر Google Sign-In
- ✅ تعطيل التفاعل أثناء التحميل
- ✅ الرولي عبر محتوى النموذج

#### ChatScreen Widget Tests
**الملف:** `test/features/chat/presentation/screens/chat_screen_widget_test.dart`

**الاختبارات:**
- ✅ عرض شريط التطبيق (AppBar)
- ✅ عرض مؤشر التحميل
- ✅ عرض قائمة الرسائل عند التحميل
- ✅ عرض رسالة "لا توجد رسائل" عندما تكون القائمة فارغة
- ✅ عرض رسالة الخطأ
- ✅ عرض حقل الإدخال
- ✅ عرض زر الإرسال
- ✅ إرسال الرسالة عند الضغط على الزر
- ✅ مسح حقل الإدخال بعد الإرسال
- ✅ عدم إرسال الرسائل الفارغة
- ✅ الرولي عبر الرسائل

## 🚀 تشغيل الاختبارات

### تشغيل جميع الاختبارات
```bash
flutter test
```

### تشغيل اختبارات ملف معين
```bash
flutter test test/features/auth/domain/usecases/login_usecase_test.dart
```

### تشغيل اختبارات مع التغطية
```bash
flutter test --coverage
```

### تشغيل اختبار واحد فقط
```bash
flutter test -k "should return AppUser when login is successful"
```

### تشغيل مع الكلام المفصل
```bash
flutter test -v
```

## 📊 التغطية (Code Coverage)

عرض التقرير:
```bash
# تم توليد التقرير في coverage/lcov.info
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 🎯 أفضل الممارسات المستخدمة

### 1. AAA Pattern (Arrange-Act-Assert)
```dart
test('example test', () async {
  // Arrange - تحضير البيئة
  when(() => mockRepo.getValue()).thenAnswer((_) async => 42);

  // Act - تنفيذ الإجراء
  final result = await useCase.execute();

  // Assert - التحقق من النتيجة
  expect(result, equals(42));
});
```

### 2. Mocking مع Mocktail
- Mock جميع الـ Dependencies الخارجية
- استخدام `when()` و `thenAnswer()` لتحديد السلوك
- استخدام `verify()` للتحقق من الاستدعاءات

### 3. BLoC Testing مع bloc_test
```dart
blocTest<ChatBloc, ChatState>(
  'emits correct states',
  setUp: () { /* تحضير mocks */ },
  build: () => chatBloc,
  act: (bloc) => bloc.add(expectedEvent),
  expect: () => expectedStates,
);
```

### 4. Widget Testing
- استخدام `pumpWidget()` و `pumpAndSettle()` لتحديث الواجهة
- استخدام `find` للبحث عن الـ Widgets
- استخدام `tester.enterText()` و `tester.tap()` للتفاعل

## 🔍 أمثلة مفصلة

### مثال: اختبار LoginUseCase
```dart
group('LoginUseCase', () {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  test('should return AppUser on successful login', () async {
    // Mock البيانات
    const testUser = AppUser(
      id: '1',
      email: 'test@example.com',
      username: 'testuser',
    );

    when(() => mockAuthRepository.login(any(), any()))
        .thenAnswer((_) async => testUser);

    // التنفيذ
    final result = await loginUseCase.execute('test@example.com', 'pass123');

    // التحقق
    expect(result, equals(testUser));
    verify(() => mockAuthRepository.login('test@example.com', 'pass123'))
        .called(1);
  });
});
```

### مثال: اختبار AuthBloc
```dart
blocTest<AuthBloc, AuthState>(
  'login emits loading then authenticated states',
  setUp: () {
    when(() => mockLoginUseCase.execute(any(), any()))
        .thenAnswer((_) async => testUser);
  },
  build: () => authBloc,
  act: (bloc) => bloc.add(
    const AuthEvent.loginRequested(
      email: 'test@example.com',
      password: 'password',
    ),
  ),
  expect: () => [
    const AuthState.loading(),
    AuthState.authenticated(testUser),
  ],
);
```

### مثال: اختبار Widget
```dart
testWidgets('LoginScreen shows error when login fails', 
    (WidgetTester tester) async {
  when(() => mockAuthBloc.state).thenReturn(
    const AuthState.error('Invalid credentials'),
  );

  await tester.pumpWidget(createWidgetUnderTest());

  expect(find.text('Invalid credentials'), findsOneWidget);
});
```

## 📝 نصائح مهمة

1. **استخدم Mocks دائماً:** لا تستخدم Firebase الحقيقي في الاختبارات
2. **اختبر حالات الفشل:** ليس فقط حالات النجاح
3. **استخدم أسماء واضحة:** لكي يكون الاختبار قابلاً للفهم
4. **تجنب التبعيات المتعددة:** كل اختبار يجب أن يختبر شيء واحد فقط
5. **استخدم `setUp` و `tearDown`:** لتنظيف الموارد

## 🐛 استكشاف الأخطاء

### الخطأ: "The type 'X' doesn't define a constructor for 'Y'"
**الحل:** استخدم `registerFallbackValue()` في `setUp()`

### الخطأ: "The method 'X' on null has been called"
**الحل:** تأكد من أن جميع الـ mocks تم إعدادها في `setUp()`

### الخطأ: "Expected 1 call(s) but got 0"
**الحل:** تحقق من أن الحدث يتم بث correctly وأن الـ mock مُعد بشكل صحيح

## 📚 المراجع

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [BloC Testing Guide](https://bloclibrary.dev/#/fluttercountertodosfirebase?id=testing)
- [Mocktail Package](https://pub.dev/packages/mocktail)
- [bloc_test Package](https://pub.dev/packages/bloc_test)

## ✅ قائمة التحقق

- [ ] تم تشغيل جميع الاختبارات بنجاح
- [ ] التغطية أكثر من 80%
- [ ] جميع الحالات الحدية مختبرة
- [ ] لا توجد أخطاء في الـ logging
- [ ] الاختبارات تعمل بشكل مستقل
- [ ] Mocks تم إعدادها بشكل صحيح

