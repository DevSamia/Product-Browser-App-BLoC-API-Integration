// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductDetailModel _$ProductDetailModelFromJson(
  Map<String, dynamic> json,
) => _ProductDetailModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  price: (json['price'] as num).toDouble(),
  thumbnail: json['thumbnail'] as String,
  category: json['category'] as String,
  discountPercentage: (json['discountPercentage'] as num).toDouble(),
  stock: (json['stock'] as num).toInt(),
  tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
  sku: json['sku'] as String,
  weight: (json['weight'] as num).toInt(),
  dimensions: Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>),
  warrantyInformation: json['warrantyInformation'] as String,
  shippingInformation: json['shippingInformation'] as String,
  availabilityStatus: json['availabilityStatus'] as String,
  reviews: (json['reviews'] as List<dynamic>)
      .map((e) => Review.fromJson(e as Map<String, dynamic>))
      .toList(),
  returnPolicy: json['returnPolicy'] as String,
  minimumOrderQuantity: (json['minimumOrderQuantity'] as num).toInt(),
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
  images: (json['images'] as List<dynamic>).map((e) => e as String).toList(),
  description: json['description'] as String,
  rating: (json['rating'] as num).toDouble(),
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
