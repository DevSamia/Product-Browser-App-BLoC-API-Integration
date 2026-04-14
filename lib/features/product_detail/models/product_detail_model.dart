import '../../product/models/product_model.dart';

class ProductDetailModel extends ProductModel {
  @override
  final String description;
  @override
  final double rating;

  final String stockStatus;

  ProductDetailModel({
    required super.id,
    required super.title,
    required super.price,
    required super.thumbnail,
    required super.category,
    required super.discountPercentage,
    required super.stock,
    required super.tags,
    required super.sku,
    required super.weight,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.meta,
    required super.images,
    required this.description,
    required this.rating,
    required this.stockStatus,
  }) : super(description: description, rating: rating);

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] ?? '',
      category: json['category'] ?? '',
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      sku: json['sku'] ?? '',

      weight: (json['weight'] as num?)?.toInt() ?? 0,

      dimensions: json['dimensions'] != null
          ? Dimensions.fromJson(json['dimensions'])
          : Dimensions(width: 0.0, height: 0.0, depth: 0.0),

      warrantyInformation: json['warrantyInformation'] ?? '',
      shippingInformation: json['shippingInformation'] ?? '',
      availabilityStatus: json['availabilityStatus'] ?? '',
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((i) => Review.fromJson(i)).toList()
          : [],
      returnPolicy: json['returnPolicy'] ?? '',
      minimumOrderQuantity: json['minimumOrderQuantity'] ?? 1,

      meta: json['meta'] != null
          ? Meta.fromJson(json['meta'])
          : Meta(
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              barcode: '',
              qrCode: '',
            ),

      images: json['images'] != null ? List<String>.from(json['images']) : [],

      description: json['description'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stockStatus: json['availabilityStatus'] ?? 'In Stock',
    );
  }
}
