// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    _ProductResponse(
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: (json['total'] as num?)?.toInt() ?? 0,
      skip: (json['skip'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ProductResponseToJson(_ProductResponse instance) =>
    <String, dynamic>{
      'products': instance.products,
      'total': instance.total,
      'skip': instance.skip,
      'limit': instance.limit,
    };

_ProductModel _$ProductModelFromJson(
  Map<String, dynamic> json,
) => _ProductModel(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
  description: json['description'] as String? ?? '',
  category: json['category'] as String? ?? '',
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  stock: (json['stock'] as num?)?.toInt() ?? 0,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  brand: json['brand'] as String?,
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
  thumbnail: json['thumbnail'] as String? ?? '',
);

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'discountPercentage': instance.discountPercentage,
      'rating': instance.rating,
      'stock': instance.stock,
      'tags': instance.tags,
      'brand': instance.brand,
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
      'thumbnail': instance.thumbnail,
    };

_ProductDimensions _$ProductDimensionsFromJson(Map<String, dynamic> json) =>
    _ProductDimensions(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$ProductDimensionsToJson(_ProductDimensions instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };

_ProductMeta _$ProductMetaFromJson(Map<String, dynamic> json) => _ProductMeta(
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  barcode: json['barcode'] as String? ?? '',
  qrCode: json['qrCode'] as String? ?? '',
);

Map<String, dynamic> _$ProductMetaToJson(_ProductMeta instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'barcode': instance.barcode,
      'qrCode': instance.qrCode,
    };

_ProductReview _$ProductReviewFromJson(Map<String, dynamic> json) =>
    _ProductReview(
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      comment: json['comment'] as String? ?? '',
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      reviewerName: json['reviewerName'] as String? ?? '',
      reviewerEmail: json['reviewerEmail'] as String? ?? '',
    );

Map<String, dynamic> _$ProductReviewToJson(_ProductReview instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
      'date': instance.date?.toIso8601String(),
      'reviewerName': instance.reviewerName,
      'reviewerEmail': instance.reviewerEmail,
    };
