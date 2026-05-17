import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_event.freezed.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.loadByCategory(String categorySlug) =
      _LoadByCategory;
  const factory ProductEvent.search(String query) = _Search;
}
