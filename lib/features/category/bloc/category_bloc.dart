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
    emit(const CategoryState.loading());

    try {
      final categories = await categoryRepository.getAllCategory();
      emit(CategoryState.success(categories: categories));
    } catch (e) {
      emit(CategoryState.error(message: "فشل في جلب الفئات: ${e.toString()}"));
    }
  }
}
