import 'package:freezed_annotation/freezed_annotation.dart';

import '../../product_detail/models/product_detail_model.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required ProductDetailModel product,
    @Default(1) int quantity,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
