import '../../../core/imports/common_imports.dart';

class CategoryWebServices {
  late Dio dio;

  CategoryWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );

    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCategory() async {
    try {
      Response response = await dio.get(categories);
      if (kDebugMode) {
        print(response.data.toString());
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  Future<List<dynamic>> getCategoryWebServices(String charName) async {
    try {
      Response response = await dio.get(
        'quote',
        queryParameters: {'author': charName},
      );
      if (kDebugMode) {
        print(response.data.toString());
      }
      return response.data;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}
