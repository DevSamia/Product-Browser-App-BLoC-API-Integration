import '../../../core/imports/common_imports.dart';
import '../models/category_model.dart';

@immutable
sealed class CategoryState {}
// 1. حالة البداية (قبل ما يصير أي شي)

final class CategoryInitial extends CategoryState {}

// 2. حالة التحميل (لما تظهر الدائرة اللي بتلف Spinner)
class CategoryLoading extends CategoryState {}

// 3. حالة النجاح (لما البيانات ترجع ونعرضها في القائمة)
class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  CategorySuccess(this.categories);
}

// 4. حالة الخطأ (لو فصل النت أو فشل الطلب)
class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
