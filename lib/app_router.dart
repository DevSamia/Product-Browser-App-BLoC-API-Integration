import '/core/imports/common_imports.dart';

class AppRouter {
  late CategoryRepository categoryRepository;
  late CategoryWebServices categoryWebServices;

  AppRouter() {
    categoryWebServices = CategoryWebServices();
    categoryRepository = CategoryRepository(categoryWebServices);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case bottomNavigationBarScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    CategoryBloc(categoryRepository)..add(GetCategoriesEvent()),
              ),
              BlocProvider(create: (context) => getIt<CartBloc>()),
            ],
            child: const BottomNavigationBarScreen(),
          ),
        );

      case '/product_details':
        final product = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ProductDetailBloc(ProductDetailWebService(Dio())),
            child: ProductDetailScreen(productId: (product as dynamic).id),
          ),
        );

      case '/cart_screen':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<CartBloc>()..add(LoadCartEvent()),
            child: const CartScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
