import 'dart:convert';

import 'package:blog_app/services/global.dart';
import 'package:blog_app/utils/constants.dart';
import 'package:get/get.dart';
import '../models/blogs.dart';

class MainApplicationController extends GetxController {
  Future<List<Blog>> fetchDataFromApi() async {
    try {
      final response = await Global.apiClient.getData(Constants.blogEndpoint);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data['blogs'];
        final List<Blog> blogList =
            responseData.map((json) => Blog.fromJson(json)).toList();

        final cachedDataList = blogList
            .map((blog) => jsonEncode(blog.toJson()))
            .toList()
            .toString();
        await Global.storageServices.setString('data', cachedDataList);

        return blogList;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
