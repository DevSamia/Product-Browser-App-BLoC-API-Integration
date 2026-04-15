import '../../../core/imports/common_imports.dart';

class ProductDetailRepository {
  final ProductDetailWebService _detailService;

  ProductDetailRepository(this._detailService);

  Future<ProductDetailModel> fetchProductDetails(int productId) async {
    try {
      final productDetail = await _detailService.getProductDetails(productId);
      return productDetail;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw "An unexpected error occurred while loading the details.";
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "The server connection timed out, please check your internet connection.";
      case DioExceptionType.receiveTimeout:
        return "The server took a long time to respond.";
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) return "Product not found.";
        return "Failed to retrieve data from the server (Error: $statusCode).";
      case DioExceptionType.cancel:
        return "The data retrieval request has been cancelled.";
      default:
        return "There is no internet connection.";
    }
  }
}
