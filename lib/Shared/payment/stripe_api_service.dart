import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post({
    required String url,
    required Map<String, dynamic> data,
    required Map<String, String> headers,
  }) async {
    var response = await dio.post(
      url,
      data: data,
      options: Options(headers: headers),
    );
    return response;
  }
}
