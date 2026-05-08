import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/product_model.dart';

part 'product_state.freezed.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;

  const factory ProductState.loading() = _Loading;

  const factory ProductState.loaded({
    required List<ProductModel> allProducts,
    required List<ProductModel> filteredProducts,
  }) = _Loaded;

  const factory ProductState.error({required String message}) = _Error;
}
