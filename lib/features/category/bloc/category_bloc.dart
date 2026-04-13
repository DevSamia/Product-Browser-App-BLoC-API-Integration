import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/category_repository.dart';
import '../models/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc(this.categoryRepository) : super(CategoryInitial()) {
    // تسجيل المعالج لحدث جلب الفئات
    on<GetCategoriesEvent>((event, emit) async {
      // 1. إرسال حالة التحميل
      emit(CategoryLoading());

      try {
        // 2. طلب البيانات من الـ Repository
        final List<dynamic> categoriesData = await categoryRepository
            .getAllCategory();

        // 3. تحويل القائمة (casting) وإرسال حالة النجاح
        // استخدمنا .from لضمان تحويل الأنواع بشكل سليم لـ CategoryModel
        final categories = List<CategoryModel>.from(categoriesData);

        emit(CategorySuccess(categories));
      } catch (e) {
        // 4. في حال حدوث خطأ
        emit(CategoryError("فشل في جلب الفئات: ${e.toString()}"));
      }
    });
  }
}
