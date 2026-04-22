import '../../features/chat/bloc/chat_bloc.dart';
import '../../features/chat/data/chat_service.dart';
import '../imports/common_imports.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  // 1. External
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  getIt.registerLazySingleton<Dio>(() => Dio());

  // 2. Web Services / Remote Data Sources
  getIt.registerLazySingleton<CartWebServices>(() => CartWebServices(getIt()));
  getIt.registerLazySingleton<CategoryWebServices>(() => CategoryWebServices());
  getIt.registerLazySingleton<ProductWebServices>(() => ProductWebServices());
  getIt.registerLazySingleton<ChatService>(() => ChatService());
  getIt.registerLazySingleton<ProductDetailWebService>(
    () => ProductDetailWebService(getIt()),
  );

  // 3. Repositories
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepository(getIt<CartWebServices>(), getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt()),
  );

  // 4. Blocs
  getIt.registerFactory(() => CategoryBloc(getIt()));
  getIt.registerFactory(() => CartBloc(getIt()));
  getIt.registerFactory(() => ProductBloc(getIt()));
  getIt.registerFactory(() => ChatBloc(getIt()));
}
