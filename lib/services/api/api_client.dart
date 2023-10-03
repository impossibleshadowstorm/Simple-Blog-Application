import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://intent-kit-16.hasura.app/api/rest/';
  String? token;
  Map<String, String> mainHeaders = {
    "x-hasura-admin-secret":
        "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6",
  };

  ApiClient();

  Future<Response> getData(String path) async {
    try {
      Response response = await _dio
          .get(
            "$_baseUrl$path",
            options: Options(headers: mainHeaders),
          )
          .timeout(const Duration(seconds: 50));
      return response;
    } catch (e) {
      log(e.toString());
      return Response(
        statusCode: 1,
        requestOptions: RequestOptions(
          headers: mainHeaders,
          baseUrl: _baseUrl + path,
        ),
      );
    }
  }
}
