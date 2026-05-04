import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection_container.dart';
import 'core/errors/app_bloc_observer.dart';
import 'core/imports/common_imports.dart';
import 'l10n/app_localizations.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  await initGetIt();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => ProductBrowserApp(appRouter: AppRouter()),
    ),
  );
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
            BlocProvider(
              create: (context) =>
                  getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: ThemeMode.system,
            title: 'Product Browser',
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [Locale('en'), Locale('ar')],
            home: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.maybeWhen(
                  authenticated: (user) => const BottomNavigationBarScreen(),
                  unauthenticated: () => const LoginScreen(),
                  initial: () => const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  orElse: () => const LoginScreen(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
