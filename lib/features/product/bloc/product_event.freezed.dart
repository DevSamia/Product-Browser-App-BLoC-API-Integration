// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProductEvent()';
}


}

/// @nodoc
class $ProductEventCopyWith<$Res>  {
$ProductEventCopyWith(ProductEvent _, $Res Function(ProductEvent) __);
}


/// Adds pattern-matching-related methods to [ProductEvent].
extension ProductEventPatterns on ProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadByCategory value)?  loadByCategory,TResult Function( _Search value)?  search,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadByCategory() when loadByCategory != null:
return loadByCategory(_that);case _Search() when search != null:
return search(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadByCategory value)  loadByCategory,required TResult Function( _Search value)  search,}){
final _that = this;
switch (_that) {
case _LoadByCategory():
return loadByCategory(_that);case _Search():
return search(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadByCategory value)?  loadByCategory,TResult? Function( _Search value)?  search,}){
final _that = this;
switch (_that) {
case _LoadByCategory() when loadByCategory != null:
return loadByCategory(_that);case _Search() when search != null:
return search(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String categorySlug)?  loadByCategory,TResult Function( String query)?  search,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadByCategory() when loadByCategory != null:
return loadByCategory(_that.categorySlug);case _Search() when search != null:
return search(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String categorySlug)  loadByCategory,required TResult Function( String query)  search,}) {final _that = this;
switch (_that) {
case _LoadByCategory():
return loadByCategory(_that.categorySlug);case _Search():
return search(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String categorySlug)?  loadByCategory,TResult? Function( String query)?  search,}) {final _that = this;
switch (_that) {
case _LoadByCategory() when loadByCategory != null:
return loadByCategory(_that.categorySlug);case _Search() when search != null:
return search(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _LoadByCategory implements ProductEvent {
  const _LoadByCategory(this.categorySlug);
  

 final  String categorySlug;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadByCategoryCopyWith<_LoadByCategory> get copyWith => __$LoadByCategoryCopyWithImpl<_LoadByCategory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadByCategory&&(identical(other.categorySlug, categorySlug) || other.categorySlug == categorySlug));
}


@override
int get hashCode => Object.hash(runtimeType,categorySlug);

@override
String toString() {
  return 'ProductEvent.loadByCategory(categorySlug: $categorySlug)';
}


}

/// @nodoc
abstract mixin class _$LoadByCategoryCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$LoadByCategoryCopyWith(_LoadByCategory value, $Res Function(_LoadByCategory) _then) = __$LoadByCategoryCopyWithImpl;
@useResult
$Res call({
 String categorySlug
});




}
/// @nodoc
class __$LoadByCategoryCopyWithImpl<$Res>
    implements _$LoadByCategoryCopyWith<$Res> {
  __$LoadByCategoryCopyWithImpl(this._self, this._then);

  final _LoadByCategory _self;
  final $Res Function(_LoadByCategory) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categorySlug = null,}) {
  return _then(_LoadByCategory(
null == categorySlug ? _self.categorySlug : categorySlug // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Search implements ProductEvent {
  const _Search(this.query);
  

 final  String query;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchCopyWith<_Search> get copyWith => __$SearchCopyWithImpl<_Search>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Search&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ProductEvent.search(query: $query)';
}


}

/// @nodoc
abstract mixin class _$SearchCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory _$SearchCopyWith(_Search value, $Res Function(_Search) _then) = __$SearchCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$SearchCopyWithImpl<$Res>
    implements _$SearchCopyWith<$Res> {
  __$SearchCopyWithImpl(this._self, this._then);

  final _Search _self;
  final $Res Function(_Search) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_Search(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
