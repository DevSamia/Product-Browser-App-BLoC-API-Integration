import '../constants/strings.dart' as api_constants;
import '../imports/common_imports.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: api_constants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  });

  getIt.registerLazySingleton<CartWebServices>(() => CartWebServices(getIt()));
  getIt.registerLazySingleton<CategoryWebServices>(
    () => CategoryWebServices(getIt()),
  );
  getIt.registerLazySingleton<ProductWebServices>(
    () => ProductWebServices(getIt()),
  );
  getIt.registerLazySingleton<ProductDetailWebService>(
    () => ProductDetailWebService(getIt()),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepository(getIt<CartWebServices>(), getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<AuthRepository>(() => FirebaseAuthRepository());

  getIt.registerLazySingleton<ChatRepository>(
    () => FirestoreChatRepository(getIt<FirebaseFirestore>()),
  );

  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));

  getIt.registerLazySingleton(
    () => WatchMessagesUseCase(getIt<ChatRepository>()),
  );
  getIt.registerLazySingleton(
    () => SendMessageUseCase(getIt<ChatRepository>()),
  );

  getIt.registerLazySingleton(() => CategoryBloc(getIt()));
  getIt.registerLazySingleton(() => CartBloc(getIt()));
  getIt.registerFactory(() => ProductBloc(getIt()));
  getIt.registerFactory(() => ProductDetailBloc(getIt()));

  getIt.registerFactory(
    () => ChatBloc(
      watchMessagesUseCase: getIt<WatchMessagesUseCase>(),
      sendMessageUseCase: getIt<SendMessageUseCase>(),
      prefs: getIt<SharedPreferences>(),
    ),
  );

  getIt.registerFactory(
    () => AuthBloc(
      loginUseCase: getIt(),
      registerUseCase: getIt(),
      getCurrentUserUseCase: getIt(),
      updateProfileUseCase: getIt(),
      authRepository: getIt(),
    ),
  );
}
