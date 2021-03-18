import 'package:dio/dio.dart';

class RestApiServices {

  static Dio getDio() {
    var dio = Dio();
    dio.options.baseUrl = 'https://en.wikipedia.org//w/api.php?';
    return dio;
  }
}