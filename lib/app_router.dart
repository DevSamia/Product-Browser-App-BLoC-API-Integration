import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation_bar.dart';
import 'core/constants/strings.dart';
import 'features/cart/view/cart_screen.dart';
import 'features/category/bloc/category_bloc.dart';
import 'features/category/bloc/category_event.dart';
import 'features/category/data/category_repository.dart';
import 'features/category/data/category_web_services.dart';
import 'features/product_detail/bloc/product_detail_bloc.dart';
import 'features/product_detail/data/product_detail_service.dart';
import 'features/product_detail/view/product_detail_screen.dart';

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
          builder: (_) => BlocProvider(
            create: (context) =>
                CategoryBloc(categoryRepository)..add(GetCategoriesEvent()),
            child: const BottomNavigationBarScreen(),
          ),
        );

      case '/product_details':
        final product = settings.arguments;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ProductDetailBloc(ProductDetailService(Dio())),
            child: ProductDetailScreen(
              product: product as dynamic,
              productId: (product as dynamic).id,
            ),
          ),
        );

      case '/cart_screen':
        return MaterialPageRoute(builder: (_) => const CartScreen());

      default:
        return null;
    }
  }
}
