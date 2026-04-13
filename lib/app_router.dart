import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_navigation_bar.dart';
import 'core/constants/strings.dart';
import 'features/category/bloc/category_bloc.dart';
import 'features/category/bloc/category_event.dart';
import 'features/category/data/category_repository.dart';
import 'features/category/data/category_web_services.dart';

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
    }
    return null;
  }
}
