import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/imports/common_imports.dart';
import 'features/category/view/category_screen.dart';
import 'features/product/bloc/product_bloc.dart';
import 'features/product/data/product_repository.dart';
import 'features/product/data/product_web_services.dart';
import 'features/product/view/product_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CategoryScreen(),
    const ProductListScreen(categoryName: ''),
    const Center(child: Text('السلة')),
    const Center(child: Text('حسابي')),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc(ProductRepository(ProductWebServices())),
        ),
      ],
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
