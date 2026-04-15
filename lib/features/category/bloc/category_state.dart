import '../../../core/imports/common_imports.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;
  CategorySuccess(this.categories);
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
}
