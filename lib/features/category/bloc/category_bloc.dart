import '../../../core/imports/common_imports.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(const CategoryState.initial()) {
    on<GetCategoriesEvent>(_onGetCategories);
  }

  Future<void> _onGetCategories(
    GetCategoriesEvent event,
    Emitter<CategoryState> emit,
  ) async {
    AppLogger.i("🚀 Bloc Event: GetCategoriesEvent triggered");

    emit(const CategoryState.loading());

    try {
      final categories = await categoryRepository.getAllCategory();
      AppLogger.i(
        "🟢 Bloc Success: Categories loaded (${categories.length} items)",
      );

      emit(CategoryState.success(categories: categories));
    } catch (e, stackTrace) {
      AppLogger.e("🔴 Bloc Error: Failed to fetch categories", e, stackTrace);

      emit(
        CategoryState.error(
          message: "Failed to fetch categories: ${e.toString()}",
        ),
      );
    }
  }
}
