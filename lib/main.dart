import 'package:firebase_core/firebase_core.dart';

import 'core/imports/common_imports.dart';

final getIt = GetIt.instance;

Future<void> initGetIt() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  getIt.registerLazySingleton<Dio>(() => Dio());

  getIt.registerLazySingleton<CartWebServices>(() => CartWebServices(getIt()));
  getIt.registerLazySingleton<CategoryWebServices>(() => CategoryWebServices());
  getIt.registerLazySingleton<ProductWebServices>(() => ProductWebServices());
  getIt.registerLazySingleton<ProductDetailWebService>(
    () => ProductDetailWebService(getIt()),
  );

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(getIt()),
  );
  getIt.registerLazySingleton<CartRepository>(
    () => CartRepository(getIt<CartWebServices>(), getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt()),
  );

  getIt.registerFactory(() => CategoryBloc(getIt()));
  getIt.registerFactory(() => CartBloc(getIt()));
  getIt.registerFactory(() => ProductBloc(getIt()));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initGetIt();
  runApp(ProductBrowserApp(appRouter: AppRouter()));
}

class ProductBrowserApp extends StatelessWidget {
  final AppRouter appRouter;

  const ProductBrowserApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<CartBloc>()),
            BlocProvider(
              create: (context) =>
                  getIt<CategoryBloc>()..add(GetCategoriesEvent()),
            ),
            BlocProvider(create: (context) => getIt<ProductBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            theme: ThemeData(useMaterial3: true),
            title: 'Product Browser',
          ),
        );
      },
    );
  }
}
