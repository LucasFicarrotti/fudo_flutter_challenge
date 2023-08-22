import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:fudo_flutter_challenge/src/posts/domain/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/posts_rep.dart';

class PostsRepImpl implements PostsRep {
  @override
  Future<Either<String, List<Post>>> getPosts() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<Post> postsList = <Post>[];
        final jsonData = json.decode(response.body);
        final pref = await SharedPreferences.getInstance();

        for (var data in jsonData) {
          final post = Post.fromJson(data);
          postsList.add(post);
        }

        List<String> postsStringList =
            postsList.map((post) => jsonEncode(post.toJson())).toList();
        pref.setStringList('posts', postsStringList);

        return Right(postsList);
      } else {
        return const Left('No se pudieron obtener los posts');
      }
    } catch (e) {
      return const Left('No se pudieron obtener los posts');
    }
  }

  @override
  Future<List<Post>> getSavedPosts() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final postsList = (pref.getStringList('posts') ?? []);
    List<Post> posts =
        postsList.map((post) => Post.fromJson(jsonDecode(post))).toList();
    return posts;
  }
}
