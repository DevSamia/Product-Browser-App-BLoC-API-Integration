import '/core/imports/common_imports.dart';
import 'bottom_navigation_bar.dart';
import 'core/di/injection_container.dart';
import 'features/auth/view/register/view/register_screen.dart';
import 'features/product/view/product_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: const LoginScreen(),
          ),
        );

      case registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthBloc>(),
            child: const RegisterScreen(),
          ),
        );

      case bottomNavigationBarScreen:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    getIt<CategoryBloc>()..add(GetCategoriesEvent()),
              ),
              BlocProvider(create: (context) => getIt<CartBloc>()),
              BlocProvider.value(value: getIt<AuthBloc>()),
            ],
            child: const BottomNavigationBarScreen(),
          ),
        );

      case productDetailScreen:
        final product = settings.arguments as ProductModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<ProductDetailBloc>()
                  ..add(FetchProductDetailEvent(product.id)),
            child: ProductDetailScreen(productId: product.id),
          ),
        );
      case productListScreen:
        final categoryName = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<ProductBloc>()
                  ..add(ProductEvent.loadByCategory(categoryName)),
            child: ProductListScreen(categoryName: categoryName),
          ),
        );

      case editProfileScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<AuthBloc>(),
            child: const EditProfileScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
