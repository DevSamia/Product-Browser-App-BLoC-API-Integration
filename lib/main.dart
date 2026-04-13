import 'app_router.dart';
import 'core/imports/common_imports.dart';

void main() {
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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
