import 'package:get_it/get_it.dart';

import 'app_router.dart';
import 'core/imports/common_imports.dart';
import 'features/cart/bloc/cart_bloc.dart';

final getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
            BlocProvider(create: (context) => CartBloc()),
            BlocProvider(
              create: (context) => ProductBloc(getIt<ProductRepository>()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: appRouter.generateRoute,
            title: 'Product Browser',
          ),
        );
      },
    );
  }
}
