import 'package:flutter_mvvm/models/post_model.dart';
import 'package:flutter_mvvm/services/api_service.dart';
import 'package:flutter_mvvm/utils/hive_boxes.dart';

class PostRepository {
  final ApiService _apiService = ApiService();

  Future<List<PostModel>> getPosts() async{
    try {
      final response = await _apiService.getPosts();
      List data = response.data;

      List<PostModel> posts = 
          data.map((e) => PostModel.fromJson(e)).toList();

      // saving posts to the Hive
      final box = HiveBoxes.getPostBox();
      box.clear();

      box.put(
          'posts',
          posts.map((e) => e.toJson()).toList(),
      );

      return posts;
    } catch (e) {
      // returning catch data
      final box = HiveBoxes.getPostBox();
      List? cachedData = box.get("posts");

      if (cachedData != null) {
        return cachedData
            .map((e) => PostModel.fromJson(Map<String,dynamic>.from(e))).toList();
      }
      rethrow;
    }
  }
}