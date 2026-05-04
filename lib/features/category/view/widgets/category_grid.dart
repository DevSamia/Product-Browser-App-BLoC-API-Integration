import '../../../../core/imports/common_imports.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (messageKey) {
            final displayMessage = messageKey == "failedToLoadCategories"
                ? context.l10n.failedToLoadCategories
                : context.l10n.errorUnknown;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.error,
                    size: 40,
                  ),
                  AppSizes.h10,
                  PrimaryText(
                    displayMessage,
                    textAlign: TextAlign.center,
                    color: AppColors.textMuted,
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CategoryBloc>().add(GetCategoriesEvent());
                    },
                    child: PrimaryText(
                      context.l10n.tryAgain,
                      color: AppColors.secondary,
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
