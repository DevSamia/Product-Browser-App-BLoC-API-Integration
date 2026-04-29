import '/core/imports/common_imports.dart';

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
              // BlocProvider.value(value: getIt<AuthBloc>()),
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
                  ..add(LoadProductsByCategoryEvent(categoryName)),
            child: ProductListScreen(categoryName: categoryName),
          ),
        );

      // case editProfileScreen:
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider.value(
      //       value: getIt<AuthBloc>(), // نستخدم القيمة الموجودة مسبقاً لأنها تحمل بيانات المستخدم
      //       child: const EditProfileScreen(),
      //     ),
      //   );

      default:
        return null;
    }
  }
}
