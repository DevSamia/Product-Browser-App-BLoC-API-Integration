import 'package:freezed_annotation/freezed_annotation.dart';

import '../../product/models/product_model.dart';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

@freezed
abstract class ProductDetailModel with _$ProductDetailModel {
  const factory ProductDetailModel({
    @Default(0) int id,
    @Default('') String title,
    @Default(0.0) double price,
    @Default('') String thumbnail,
    @Default('') String category,
    @Default(0.0) double discountPercentage,
    @Default(0) int stock,
    @Default([]) List<String> tags,
    @Default('') String sku,
    @Default(0) int weight,
    ProductDimensions? dimensions,
    @Default('') String warrantyInformation,
    @Default('') String shippingInformation,
    @Default('') String availabilityStatus,
    @Default([]) List<ProductReview> reviews,
    @Default('') String returnPolicy,
    @Default(1) int minimumOrderQuantity,
    ProductMeta? meta,
    @Default([]) List<String> images,
    @Default('') String description,
    @Default(0.0) double rating,
    @Default('In Stock') String stockStatus,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);
}
