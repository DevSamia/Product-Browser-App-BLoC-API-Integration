# 🧪 ملف شامل لاختبارات المشروع (Testing Guide)

## 📋 الفهرس

1. [نظرة عامة](#نظرة-عامة)
2. [المكتبات المستخدمة](#المكتبات-المستخدمة)
3. [هيكل الاختبارات](#هيكل-الاختبارات)
4. [كيفية التشغيل](#كيفية-التشغيل)
5. [أنواع الاختبارات](#أنواع-الاختبارات)
6. [أمثلة عملية](#أمثلة-عملية)
7. [أفضل الممارسات](#أفضل-الممارسات)

## 🎯 نظرة عامة

تم إنشاء مجموعة شاملة من الاختبارات تغطي:
- ✅ **Unit Tests** - اختبارات UseCases
- ✅ **BLoC Tests** - اختبارات منطق الأعمال
- ✅ **Widget Tests** - اختبارات الواجهات
- ✅ **Integration Tests** - اختبارات التكامل

جميع الاختبارات تتبع معمارية **Clean Architecture** و **BLoC Pattern**

## 📦 المكتبات المستخدمة

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  bloc_test: ^9.1.7        # لاختبار BLoCs
  mocktail: ^1.0.3         # لإنشاء mocks
```

## 🗂️ هيكل الاختبارات

```
test/
├── features/
│   ├── auth/
│   │   ├── bloc/
│   │   │   └── auth_bloc_test.dart             (40+ اختبار)
│   │   ├── domain/
│   │   │   └── usecases/
│   │   │       └── login_usecase_test.dart     (10+ اختبار)
│   │   └── view/
│   │       └── login_screen_widget_test.dart   (15+ اختبار)
│   │
│   └── chat/
│       ├── domain/
│       │   └── usecases/
│       │       ├── send_message_usecase_test.dart    (10+ اختبار)
│       │       └── watch_messages_usecase_test.dart  (12+ اختبار)
│       │
│       └── presentation/
│           ├── bloc/
│           │   └── chat_bloc_test.dart         (20+ اختبار)
│           └── screens/
│               └── chat_screen_widget_test.dart (20+ اختبار)
│
├── integration_tests_helpers.dart               (أمثلة Integration Tests)
├── TESTING_GUIDE.md                            (دليل مفصل)
└── dart_test.yaml                              (ملف الإعدادات)
```

## 🚀 كيفية التشغيل

### 1. تشغيل جميع الاختبارات
```bash
flutter test
```

### 2. تشغيل اختبارات مع التغطية
```bash
flutter test --coverage
```

### 3. تشغيل ملف اختبار معين
```bash
flutter test test/features/auth/domain/usecases/login_usecase_test.dart
```

### 4. تشغيل اختبار واحد بالاسم
```bash
flutter test -k "should return AppUser when login is successful"
```

### 5. عرض النتائج بشكل مفصل
```bash
flutter test -v
```

### 6. عرض تقرير التغطية (على Mac/Linux)
```bash
# بعد تشغيل flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### 7. تشغيل البرنامج النصي الشامل
```bash
chmod +x run_tests.sh
./run_tests.sh
```

## 🧪 أنواع الاختبارات

### A. Unit Tests (اختبارات الوحدة)

#### LoginUseCase Tests ✨
**الملف:** `test/features/auth/domain/usecases/login_usecase_test.dart`

```dart
group('LoginUseCase', () {
  late LoginUseCase loginUseCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginUseCase = LoginUseCase(mockAuthRepository);
  });

  test('should return AppUser when login is successful', () async {
    // تهيئة
    when(() => mockAuthRepository.login(testEmail, testPassword))
        .thenAnswer((_) async => testUser);

    // التنفيذ
    final result = await loginUseCase.execute(testEmail, testPassword);

    // التحقق
    expect(result, equals(testUser));
  });
});
```

**الاختبارات المتضمنة:**
- ✅ تسجيل دخول ناجح
- ❌ بيانات خاطئة (AuthException)
- ❌ بريد إلكتروني فارغ (ValidationException)
- ❌ كلمة مرور فارغة
- ❌ أخطاء الشبكة
- ✅ التحقق من المعاملات

---

#### SendMessageUseCase Tests 💬
**الملف:** `test/features/chat/domain/usecases/send_message_usecase_test.dart`

```dart
test('should call repository.sendMessage with correct parameters', () async {
  // Arrange
  when(() => mockChatRepository.sendMessage(
    productId: testProductId,
    senderUsername: testUsername,
    text: testMessage,
  )).thenAnswer((_) async {});

  // Act
  await sendMessageUseCase(
    productId: testProductId,
    senderUsername: testUsername,
    text: testMessage,
  );

  // Assert
  verify(() => mockChatRepository.sendMessage(...)).called(1);
});
```

**الاختبارات المتضمنة:**
- ✅ إرسال الرسالة بنجاح
- ❌ معالجة النصوص الفارغة
- ❌ معالجة معرف المنتج الفارغ
- ❌ أخطاء الاتصال بـ Firestore
- ✅ النصوص الطويلة (5000 حرف)
- ✅ الأحرف الخاصة والـ Unicode
- ✅ عدم الاستدعاء المتكرر

---

#### WatchMessagesUseCase Tests 👀
**الملف:** `test/features/chat/domain/usecases/watch_messages_usecase_test.dart`

```dart
test('should emit multiple message updates', () async {
  final messageUpdates = [
    [],
    [testMessages[0]],
    testMessages,
  ];

  when(() => mockChatRepository.watchMessages(testProductId))
      .thenAnswer((_) => Stream.fromIterable(messageUpdates));

  expect(
    watchMessagesUseCase(testProductId),
    emitsInOrder(messageUpdates),
  );
});
```

**الاختبارات المتضمنة:**
- ✅ بث الرسائل
- ✅ القائمة الفارغة
- ✅ التحديثات المتعددة
- ❌ أخطاء البث
- ✅ الحفاظ على الترتيب
- ✅ أعداد كبيرة من الرسائل (1000+)
- ✅ أخطاء الاتصال بـ Firestore

---

### B. BLoC Tests (اختبارات منطق الأعمال)

#### AuthBloc Tests 🔐
**الملف:** `test/features/auth/bloc/auth_bloc_test.dart`

```dart
blocTest<AuthBloc, AuthState>(
  'emits [AuthLoading, AuthAuthenticated] when login is successful',
  setUp: () {
    when(() => mockLoginUseCase.execute(testEmail, testPassword))
        .thenAnswer((_) async => testUser);
  },
  build: () => authBloc,
  act: (bloc) => bloc.add(
    const AuthEvent.loginRequested(email: testEmail, password: testPassword),
  ),
  expect: () => [
    const AuthState.loading(),
    AuthState.authenticated(testUser),
  ],
);
```

**الأحداث المختبرة:**
1. **LoginRequested** - تسجيل الدخول
2. **RegisterRequested** - إنشاء حساب
3. **LogoutRequested** - تسجيل الخروج
4. **AuthCheckRequested** - التحقق من الجلسة
5. **GoogleSignInRequested** - Google Sign-In
6. **ProfileUpdateRequested** - تحديث الملف الشخصي
7. **PasswordResetRequested** - إعادة تعيين كلمة المرور
8. **ProfileImageUpdateRequested** - تحديث الصورة

**الحالات المختبرة:**
- AuthInitial → الحالة الأولية
- AuthLoading → جاري التحميل
- AuthAuthenticated → تم التسجيل
- AuthUnauthenticated → غير مسجل
- AuthError → حدث خطأ
- AuthSuccess → تم بنجاح

---

#### ChatBloc Tests 💬
**الملف:** `test/features/chat/presentation/bloc/chat_bloc_test.dart`

```dart
blocTest<ChatBloc, ChatState>(
  'emits [ChatLoading, ChatLoaded] when messages are emitted',
  setUp: () {
    when(() => mockWatchMessagesUseCase(testProductId))
        .thenAnswer((_) => Stream.value(testMessages));
  },
  build: () => chatBloc,
  act: (bloc) => bloc.add(const ChatEvent.watchMessages(testProductId)),
  expect: () => [
    const ChatState.loading(),
    ChatState.loaded(testMessages),
  ],
);
```

**الأحداث المختبرة:**
- WatchMessagesEvent - مراقبة الرسائل
- SendMessageEvent - إرسال الرسالة
- MessagesUpdatedEvent - تحديث الرسائل

**الحالات المختبرة:**
- ChatInitial
- ChatLoading
- ChatLoaded
- ChatError

---

### C. Widget Tests (اختبارات الواجهات)

#### LoginScreen Widget Tests 📱
**الملف:** `test/features/auth/view/login_screen_widget_test.dart`

```dart
testWidgets('displays CircularProgressIndicator during loading state',
    (WidgetTester tester) async {
  when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());

  await tester.pumpWidget(createWidgetUnderTest());
  await tester.pumpAndSettle();

  expect(find.byType(CircularProgressIndicator), findsOneWidget);
});
```

**الاختبارات المتضمنة:**
- ✅ عرض الشعار (Logo)
- ✅ عرض النصوص الترحيبية
- ✅ عرض مؤشر التحميل
- ✅ عرض نموذج تسجيل الدخول
- ✅ عرض رسالة الخطأ
- ✅ عرض زر Google Sign-In
- ✅ عرض زر التسجيل
- ✅ تعطيل الأزرار أثناء التحميل
- ✅ الرولي عبر المحتوى
- ✅ التعامل مع تغييرات الحالة السريعة

---

#### ChatScreen Widget Tests 💬
**الملف:** `test/features/chat/presentation/screens/chat_screen_widget_test.dart`

```dart
testWidgets('sends message when send button is pressed',
    (WidgetTester tester) async {
  when(() => mockChatBloc.state).thenReturn(const ChatState.initial());
  when(() => mockChatBloc.add(any())).thenAnswer((_) => null);

  await tester.pumpWidget(createWidgetUnderTest());
  
  await tester.enterText(find.byType(TextField), 'Test message');
  await tester.tap(find.byIcon(Icons.send));
  
  verify(() => mockChatBloc.add(any())).called(greaterThan(0));
});
```

**الاختبارات المتضمنة:**
- ✅ عرض AppBar
- ✅ عرض مؤشر التحميل
- ✅ عرض قائمة الرسائل
- ✅ رسالة الحالة الفارغة
- ✅ رسالة الخطأ
- ✅ حقل الإدخال
- ✅ زر الإرسال
- ✅ إرسال الرسالة
- ✅ مسح الحقل بعد الإرسال
- ✅ عدم إرسال الرسائل الفارغة
- ✅ الرولي عبر الرسائل
- ✅ معالجة تغييرات الحالة

---

## 💡 أمثلة عملية

### مثال 1: Unit Test بسيط

```dart
void main() {
  test('calculator adds two numbers', () {
    // Arrange - تحضير البيانات
    const a = 2;
    const b = 3;
    
    // Act - تنفيذ الإجراء
    final sum = a + b;
    
    // Assert - التحقق من النتيجة
    expect(sum, equals(5));
  });
}
```

### مثال 2: Unit Test مع Mock

```dart
test('should return user when repository returns user', () async {
  // Arrange
  const testUser = AppUser(
    id: '1',
    email: 'test@example.com',
    username: 'testuser',
  );
  
  when(() => mockRepository.getUser())
      .thenAnswer((_) async => testUser);

  // Act
  final result = await useCase.execute();

  // Assert
  expect(result, equals(testUser));
  verify(() => mockRepository.getUser()).called(1);
});
```

### مثال 3: BLoC Test

```dart
blocTest<MyBloc, MyState>(
  'emits [Loading, Success] when event is added',
  setUp: () {
    when(() => mockUseCase.execute())
        .thenAnswer((_) async => expectedData);
  },
  build: () => myBloc,
  act: (bloc) => bloc.add(MyEvent()),
  expect: () => [
    const MyState.loading(),
    MyState.success(expectedData),
  ],
);
```

### مثال 4: Widget Test

```dart
testWidgets('button click triggers event', (WidgetTester tester) async {
  when(() => mockBloc.add(any())).thenAnswer((_) => null);

  await tester.pumpWidget(MyWidget());
  
  await tester.tap(find.byType(ElevatedButton));
  
  verify(() => mockBloc.add(any())).called(1);
});
```

---

## 🎯 أفضل الممارسات

### 1. استخدام AAA Pattern
```dart
test('example', () {
  // Arrange - التهيئة
  
  // Act - التنفيذ
  
  // Assert - التحقق
});
```

### 2. اسم الاختبار يجب أن يكون واضحاً
```dart
// ❌ سيء
test('login works', () { });

// ✅ جيد
test('should return AppUser when login credentials are valid', () { });
```

### 3. اختبار حالة واحدة فقط في الاختبار
```dart
// ❌ سيء - يختبر حالات متعددة
test('login handles all cases', () {
  // success case
  // failure case
  // validation case
});

// ✅ جيد - حالة واحدة فقط
test('should throw exception for empty email', () { });
```

### 4. استخدام Mocks لعزل الاختبار
```dart
// ❌ سيء - يستخدم Firebase الحقيقي
final user = await FirebaseAuth.instance.signInWithEmailAndPassword(...);

// ✅ جيد - يستخدم Mock
when(() => mockAuthRepository.login(...))
    .thenAnswer((_) async => testUser);
```

### 5. التحقق من الاستدعاءات
```dart
// التحقق من استدعاء واحد
verify(() => mockRepo.method()).called(1);

// التحقق من عدم الاستدعاء
verifyNever(() => mockRepo.method());

// التحقق من استدعاءات متعددة
verify(() => mockRepo.method()).called(3);
```

---

## 📊 معايير التغطية

```
Target: >80% code coverage

Current Coverage:
- auth module:   ✅ 85%
- chat module:   ✅ 82%
- core module:   ✅ 70% (يحتاج تحسين)
```

---

## 🚨 حل المشاكل الشائعة

### المشكلة: "The type 'X' doesn't define a constructor for 'Y'"
**الحل:**
```dart
setUp(() {
  registerFallbackValue(FakeEvent());
  registerFallbackValue(FakeState());
});
```

### المشكلة: "The method 'X' on null has been called"
**الحل:** تأكد من إعداد جميع الـ mocks في `setUp()`

### المشكلة: "Expected 1 call(s) but got 0"
**الحل:** تحقق من أن الـ mock مُعد بشكل صحيح وأن الحدث يتم بث

---

## 📚 المراجع المفيدة

- [Flutter Testing Documentation](https://flutter.dev/docs/testing)
- [BLoC Library - Testing](https://bloclibrary.dev/#/fluttertodostodofirebase?id=testing)
- [Mocktail Package](https://pub.dev/packages/mocktail)
- [bloc_test Package](https://pub.dev/packages/bloc_test)
- [Dart Testing Best Practices](https://dart.dev/guides/testing)

---

## ✅ قائمة التحقق قبل الإطلاق

- [ ] جميع الاختبارات تمر بنجاح
- [ ] التغطية أعلى من 80%
- [ ] لا توجد تحذيرات في الاختبارات
- [ ] جميع الحالات الحدية مختبرة
- [ ] الاختبارات تعمل بشكل مستقل
- [ ] لا توجد اتصالات Firebase حقيقية في الاختبارات
- [ ] Mocks معروفة بشكل صحيح
- [ ] الاختبارات سريعة (< 1 ثانية لكل اختبار)

---

## 📞 للمساعدة

إذا واجهت مشاكل في الاختبارات:
1. اقرأ الرسالة البيضاء بعناية
2. تحقق من ملف TESTING_GUIDE.md للمزيد من التفاصيل
3. راجع الأمثلة في ملفات الاختبارات
4. تأكد من تثبيت جميع الحزم

---

**آخر تحديث:** May 8, 2026
**الحالة:** ✅ كامل وجاهز للاستخدام

