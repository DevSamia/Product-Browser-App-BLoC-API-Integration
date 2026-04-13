import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/imports/common_imports.dart';
import '../../bloc/category_bloc.dart';
import '../../bloc/category_state.dart';
import 'category_item.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategorySuccess) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.30,
            ),
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final item = state.categories[index];
              return CategoryItem(category: item, index: index);
            },
          );
        } else if (state is CategoryError) {
          return Center(child: PrimaryText(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
