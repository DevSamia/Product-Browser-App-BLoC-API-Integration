// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductDetailModel _$ProductDetailModelFromJson(
  Map<String, dynamic> json,
) => _ProductDetailModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  thumbnail: json['thumbnail'] as String? ?? '',
  category: json['category'] as String? ?? '',
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
  stock: (json['stock'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  sku: json['sku'] as String? ?? '',
  weight: (json['weight'] as num?)?.toInt() ?? 0,
  dimensions: json['dimensions'] == null
      ? null
      : ProductDimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
  warrantyInformation: json['warrantyInformation'] as String? ?? '',
  shippingInformation: json['shippingInformation'] as String? ?? '',
  availabilityStatus: json['availabilityStatus'] as String? ?? '',
  reviews:
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => ProductReview.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  returnPolicy: json['returnPolicy'] as String? ?? '',
  minimumOrderQuantity: (json['minimumOrderQuantity'] as num?)?.toInt() ?? 1,
  meta: json['meta'] == null
      ? null
      : ProductMeta.fromJson(json['meta'] as Map<String, dynamic>),
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  description: json['description'] as String? ?? '',
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  stockStatus: json['stockStatus'] as String? ?? 'In Stock',
);

Map<String, dynamic> _$ProductDetailModelToJson(_ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'price': instance.price,
      'thumbnail': instance.thumbnail,
      'category': instance.category,
      'discountPercentage': instance.discountPercentage,
      'stock': instance.stock,
      'tags': instance.tags,
      'sku': instance.sku,
      'weight': instance.weight,
      'dimensions': instance.dimensions,
      'warrantyInformation': instance.warrantyInformation,
      'shippingInformation': instance.shippingInformation,
      'availabilityStatus': instance.availabilityStatus,
      'reviews': instance.reviews,
      'returnPolicy': instance.returnPolicy,
      'minimumOrderQuantity': instance.minimumOrderQuantity,
      'meta': instance.meta,
      'images': instance.images,
      'description': instance.description,
      'rating': instance.rating,
      'stockStatus': instance.stockStatus,
    };
