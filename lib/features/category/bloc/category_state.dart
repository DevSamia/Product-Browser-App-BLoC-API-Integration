import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/category_model.dart';

part 'category_state.freezed.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState.initial() = _Initial;
  const factory CategoryState.loading() = _Loading;
  const factory CategoryState.success({
    required List<CategoryModel> categories,
    @Default('') String selectedCategorySlug,
  }) = _Success;
  const factory CategoryState.error({required String message}) = _Error;
}
