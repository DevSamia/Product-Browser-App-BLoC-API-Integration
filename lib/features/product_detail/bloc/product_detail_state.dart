import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/product_detail_model.dart';

part 'product_detail_state.freezed.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState.initial() = _Initial;
  const factory ProductDetailState.loading() = _Loading;
  const factory ProductDetailState.loaded(ProductDetailModel product) = _Loaded;
  const factory ProductDetailState.error(String message) = _Error;
}
