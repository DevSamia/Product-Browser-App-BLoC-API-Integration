import '../../../../core/imports/common_imports.dart';
import 'category_item.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          ),
          error: (messageKey) {
            final displayMessage = messageKey == "failedToLoadCategories"
                ? context.l10n.failedToLoadCategories
                : context.l10n.errorUnknown;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: colorScheme.error, size: 40),
                  AppSizes.h10,
                  PrimaryText(
                    displayMessage,
                    textAlign: TextAlign.center,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CategoryBloc>().add(GetCategoriesEvent());
                    },
                    child: PrimaryText(
                      context.l10n.tryAgain,
                      color: colorScheme.secondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            );
          },
          success: (categories, selectedSlug) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: 1.30,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
              return CategoryItem(
                category: item,
                index: index,
                isSelected: item.slug == selectedSlug,
              );
            },
          ),
        );
      },
    );
  }
}
