// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductDetailModel {

 int get id; String get title; double get price; String get thumbnail; String get category; double get discountPercentage; int get stock; List<String> get tags; String get sku; int get weight; Dimensions get dimensions; String get warrantyInformation; String get shippingInformation; String get availabilityStatus; List<Review> get reviews; String get returnPolicy; int get minimumOrderQuantity; Meta get meta; List<String> get images; String get description; double get rating; String get stockStatus;
/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailModelCopyWith<ProductDetailModel> get copyWith => _$ProductDetailModelCopyWithImpl<ProductDetailModel>(this as ProductDetailModel, _$identity);

  /// Serializes this ProductDetailModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.price, price) || other.price == price)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.category, category) || other.category == category)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.description, description) || other.description == description)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stockStatus, stockStatus) || other.stockStatus == stockStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,price,thumbnail,category,discountPercentage,stock,const DeepCollectionEquality().hash(tags),sku,weight,dimensions,warrantyInformation,shippingInformation,availabilityStatus,const DeepCollectionEquality().hash(reviews),returnPolicy,minimumOrderQuantity,meta,const DeepCollectionEquality().hash(images),description,rating,stockStatus]);

@override
String toString() {
  return 'ProductDetailModel(id: $id, title: $title, price: $price, thumbnail: $thumbnail, category: $category, discountPercentage: $discountPercentage, stock: $stock, tags: $tags, sku: $sku, weight: $weight, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, images: $images, description: $description, rating: $rating, stockStatus: $stockStatus)';
}


}

/// @nodoc
abstract mixin class $ProductDetailModelCopyWith<$Res>  {
  factory $ProductDetailModelCopyWith(ProductDetailModel value, $Res Function(ProductDetailModel) _then) = _$ProductDetailModelCopyWithImpl;
@useResult
$Res call({
 int id, String title, double price, String thumbnail, String category, double discountPercentage, int stock, List<String> tags, String sku, int weight, Dimensions dimensions, String warrantyInformation, String shippingInformation, String availabilityStatus, List<Review> reviews, String returnPolicy, int minimumOrderQuantity, Meta meta, List<String> images, String description, double rating, String stockStatus
});




}
/// @nodoc
class _$ProductDetailModelCopyWithImpl<$Res>
    implements $ProductDetailModelCopyWith<$Res> {
  _$ProductDetailModelCopyWithImpl(this._self, this._then);

  final ProductDetailModel _self;
  final $Res Function(ProductDetailModel) _then;

/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? price = null,Object? thumbnail = null,Object? category = null,Object? discountPercentage = null,Object? stock = null,Object? tags = null,Object? sku = null,Object? weight = null,Object? dimensions = null,Object? warrantyInformation = null,Object? shippingInformation = null,Object? availabilityStatus = null,Object? reviews = null,Object? returnPolicy = null,Object? minimumOrderQuantity = null,Object? meta = null,Object? images = null,Object? description = null,Object? rating = null,Object? stockStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Dimensions,warrantyInformation: null == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String,shippingInformation: null == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String,availabilityStatus: null == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,returnPolicy: null == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String,minimumOrderQuantity: null == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Meta,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,stockStatus: null == stockStatus ? _self.stockStatus : stockStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailModel].
extension ProductDetailModelPatterns on ProductDetailModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDetailModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDetailModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductDetailModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDetailModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  double price,  String thumbnail,  String category,  double discountPercentage,  int stock,  List<String> tags,  String sku,  int weight,  Dimensions dimensions,  String warrantyInformation,  String shippingInformation,  String availabilityStatus,  List<Review> reviews,  String returnPolicy,  int minimumOrderQuantity,  Meta meta,  List<String> images,  String description,  double rating,  String stockStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that.id,_that.title,_that.price,_that.thumbnail,_that.category,_that.discountPercentage,_that.stock,_that.tags,_that.sku,_that.weight,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.images,_that.description,_that.rating,_that.stockStatus);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  double price,  String thumbnail,  String category,  double discountPercentage,  int stock,  List<String> tags,  String sku,  int weight,  Dimensions dimensions,  String warrantyInformation,  String shippingInformation,  String availabilityStatus,  List<Review> reviews,  String returnPolicy,  int minimumOrderQuantity,  Meta meta,  List<String> images,  String description,  double rating,  String stockStatus)  $default,) {final _that = this;
switch (_that) {
case _ProductDetailModel():
return $default(_that.id,_that.title,_that.price,_that.thumbnail,_that.category,_that.discountPercentage,_that.stock,_that.tags,_that.sku,_that.weight,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.images,_that.description,_that.rating,_that.stockStatus);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  double price,  String thumbnail,  String category,  double discountPercentage,  int stock,  List<String> tags,  String sku,  int weight,  Dimensions dimensions,  String warrantyInformation,  String shippingInformation,  String availabilityStatus,  List<Review> reviews,  String returnPolicy,  int minimumOrderQuantity,  Meta meta,  List<String> images,  String description,  double rating,  String stockStatus)?  $default,) {final _that = this;
switch (_that) {
case _ProductDetailModel() when $default != null:
return $default(_that.id,_that.title,_that.price,_that.thumbnail,_that.category,_that.discountPercentage,_that.stock,_that.tags,_that.sku,_that.weight,_that.dimensions,_that.warrantyInformation,_that.shippingInformation,_that.availabilityStatus,_that.reviews,_that.returnPolicy,_that.minimumOrderQuantity,_that.meta,_that.images,_that.description,_that.rating,_that.stockStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductDetailModel implements ProductDetailModel {
  const _ProductDetailModel({required this.id, required this.title, required this.price, required this.thumbnail, required this.category, required this.discountPercentage, required this.stock, required final  List<String> tags, required this.sku, required this.weight, required this.dimensions, required this.warrantyInformation, required this.shippingInformation, required this.availabilityStatus, required final  List<Review> reviews, required this.returnPolicy, required this.minimumOrderQuantity, required this.meta, required final  List<String> images, required this.description, required this.rating, this.stockStatus = 'In Stock'}): _tags = tags,_reviews = reviews,_images = images;
  factory _ProductDetailModel.fromJson(Map<String, dynamic> json) => _$ProductDetailModelFromJson(json);

@override final  int id;
@override final  String title;
@override final  double price;
@override final  String thumbnail;
@override final  String category;
@override final  double discountPercentage;
@override final  int stock;
 final  List<String> _tags;
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String sku;
@override final  int weight;
@override final  Dimensions dimensions;
@override final  String warrantyInformation;
@override final  String shippingInformation;
@override final  String availabilityStatus;
 final  List<Review> _reviews;
@override List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

@override final  String returnPolicy;
@override final  int minimumOrderQuantity;
@override final  Meta meta;
 final  List<String> _images;
@override List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  String description;
@override final  double rating;
@override@JsonKey() final  String stockStatus;

/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailModelCopyWith<_ProductDetailModel> get copyWith => __$ProductDetailModelCopyWithImpl<_ProductDetailModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductDetailModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.price, price) || other.price == price)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.category, category) || other.category == category)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.stock, stock) || other.stock == stock)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.warrantyInformation, warrantyInformation) || other.warrantyInformation == warrantyInformation)&&(identical(other.shippingInformation, shippingInformation) || other.shippingInformation == shippingInformation)&&(identical(other.availabilityStatus, availabilityStatus) || other.availabilityStatus == availabilityStatus)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.returnPolicy, returnPolicy) || other.returnPolicy == returnPolicy)&&(identical(other.minimumOrderQuantity, minimumOrderQuantity) || other.minimumOrderQuantity == minimumOrderQuantity)&&(identical(other.meta, meta) || other.meta == meta)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.description, description) || other.description == description)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.stockStatus, stockStatus) || other.stockStatus == stockStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,price,thumbnail,category,discountPercentage,stock,const DeepCollectionEquality().hash(_tags),sku,weight,dimensions,warrantyInformation,shippingInformation,availabilityStatus,const DeepCollectionEquality().hash(_reviews),returnPolicy,minimumOrderQuantity,meta,const DeepCollectionEquality().hash(_images),description,rating,stockStatus]);

@override
String toString() {
  return 'ProductDetailModel(id: $id, title: $title, price: $price, thumbnail: $thumbnail, category: $category, discountPercentage: $discountPercentage, stock: $stock, tags: $tags, sku: $sku, weight: $weight, dimensions: $dimensions, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, reviews: $reviews, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, meta: $meta, images: $images, description: $description, rating: $rating, stockStatus: $stockStatus)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailModelCopyWith<$Res> implements $ProductDetailModelCopyWith<$Res> {
  factory _$ProductDetailModelCopyWith(_ProductDetailModel value, $Res Function(_ProductDetailModel) _then) = __$ProductDetailModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, double price, String thumbnail, String category, double discountPercentage, int stock, List<String> tags, String sku, int weight, Dimensions dimensions, String warrantyInformation, String shippingInformation, String availabilityStatus, List<Review> reviews, String returnPolicy, int minimumOrderQuantity, Meta meta, List<String> images, String description, double rating, String stockStatus
});




}
/// @nodoc
class __$ProductDetailModelCopyWithImpl<$Res>
    implements _$ProductDetailModelCopyWith<$Res> {
  __$ProductDetailModelCopyWithImpl(this._self, this._then);

  final _ProductDetailModel _self;
  final $Res Function(_ProductDetailModel) _then;

/// Create a copy of ProductDetailModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? price = null,Object? thumbnail = null,Object? category = null,Object? discountPercentage = null,Object? stock = null,Object? tags = null,Object? sku = null,Object? weight = null,Object? dimensions = null,Object? warrantyInformation = null,Object? shippingInformation = null,Object? availabilityStatus = null,Object? reviews = null,Object? returnPolicy = null,Object? minimumOrderQuantity = null,Object? meta = null,Object? images = null,Object? description = null,Object? rating = null,Object? stockStatus = null,}) {
  return _then(_ProductDetailModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as int,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Dimensions,warrantyInformation: null == warrantyInformation ? _self.warrantyInformation : warrantyInformation // ignore: cast_nullable_to_non_nullable
as String,shippingInformation: null == shippingInformation ? _self.shippingInformation : shippingInformation // ignore: cast_nullable_to_non_nullable
as String,availabilityStatus: null == availabilityStatus ? _self.availabilityStatus : availabilityStatus // ignore: cast_nullable_to_non_nullable
as String,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,returnPolicy: null == returnPolicy ? _self.returnPolicy : returnPolicy // ignore: cast_nullable_to_non_nullable
as String,minimumOrderQuantity: null == minimumOrderQuantity ? _self.minimumOrderQuantity : minimumOrderQuantity // ignore: cast_nullable_to_non_nullable
as int,meta: null == meta ? _self.meta : meta // ignore: cast_nullable_to_non_nullable
as Meta,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,stockStatus: null == stockStatus ? _self.stockStatus : stockStatus // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
