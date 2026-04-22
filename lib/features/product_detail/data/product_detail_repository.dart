import '../../../core/imports/common_imports.dart';

class ProductDetailRepository {
  final ProductDetailWebService _detailService;

  ProductDetailRepository(this._detailService);

  Future<ProductDetailModel> fetchProductDetails(int productId) async {
    try {
      AppLogger.i("Repository: البدء في جلب تفاصيل المنتج رقم $productId");

      final productDetail = await _detailService.getProductDetails(productId);

      AppLogger.i(
        "Repository: تم استلام بيانات المنتج ${productDetail.title} بنجاح",
      );
      return productDetail;
    } on DioException catch (e) {
      final errorMessage = _handleDioError(e);
      AppLogger.w(
        "Repository (Dio Error): $errorMessage | Status Code: ${e.response?.statusCode}",
      );
      throw errorMessage;
    } catch (e, stackTrace) {
      AppLogger.e(
        "Repository (Unexpected Error): حدث خطأ غير معروف",
        e,
        stackTrace,
      );
      throw "An unexpected error occurred while loading the details.";
    }
  }

  String _handleDioError(DioException e) {
    AppLogger.d("Dio Error Type: ${e.type}");

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return "The server connection timed out, please check your internet connection.";
      case DioExceptionType.receiveTimeout:
        return "The server took a long time to respond.";
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) return "Product not found.";
        if (statusCode == 429) {
          return "Too many requests. Please try again later.";
        }
        return "Failed to retrieve data from the server (Error: $statusCode).";
      default:
        return "There is no internet connection.";
    }
  }
}
