import 'package:freezed_annotation/freezed_annotation.dart';

import '../../product/models/product_model.dart';

part 'product_detail_model.freezed.dart';
part 'product_detail_model.g.dart';

@freezed
class ProductDetailModel with _$ProductDetailModel {
  const factory ProductDetailModel({
    required int id,
    required String title,
    required double price,
    required String thumbnail,
    required String category,
    required double discountPercentage,
    required int stock,
    required List<String> tags,
    required String sku,
    required int weight,
    required Dimensions dimensions,
    required String warrantyInformation,
    required String shippingInformation,
    required String availabilityStatus,
    required List<Review> reviews,
    required String returnPolicy,
    required int minimumOrderQuantity,
    required Meta meta,
    required List<String> images,
    required String description,
    required double rating,
    @Default('In Stock') String stockStatus,
  }) = _ProductDetailModel;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
