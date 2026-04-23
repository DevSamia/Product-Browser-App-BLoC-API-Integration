import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/chat/data/chat_web_service.dart';
import '../constants/strings.dart' as ApiConstants;
import '../imports/common_imports.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 20),
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    return dio;
  });

  // --- 2. Web Services (Remote Data Sources) ---
  getIt.registerLazySingleton<CartWebServices>(() => CartWebServices(getIt()));
  getIt.registerLazySingleton<CategoryWebServices>(
    () => CategoryWebServices(getIt()),
  );
  getIt.registerLazySingleton<ProductWebServices>(
    () => ProductWebServices(getIt()),
  );
  getIt.registerLazySingleton<ChatWebService>(() => ChatWebService());
  getIt.registerLazySingleton<ProductDetailWebService>(
    () => ProductDetailWebService(getIt()),
  );

  // --- 3. Repositories ---
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt()),
  );

  getIt.registerLazySingleton<CartRepository>(
    () => CartRepository(getIt<CartWebServices>(), getIt<SharedPreferences>()),
  );

  // --- 4. Blocs (Presentation Layer) ---
  getIt.registerFactory(() => CategoryBloc(getIt()));
  getIt.registerFactory(() => CartBloc(getIt()));
  getIt.registerFactory(() => ProductBloc(getIt()));
  getIt.registerFactory(() => ChatBloc(getIt()));
  getIt.registerFactory(() => ProductDetailBloc(getIt()));
}
