import '../../../core/imports/common_imports.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    on<GetCategoriesEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        final List<dynamic> categoriesData = await categoryRepository
            .getAllCategory();

        final categories = List<CategoryModel>.from(categoriesData);

        emit(CategorySuccess(categories));
      } catch (e) {
        emit(CategoryError("فشل في جلب الفئات: ${e.toString()}"));
      }
    });
  }
}
