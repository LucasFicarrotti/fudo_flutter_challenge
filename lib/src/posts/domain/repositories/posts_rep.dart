import 'package:dartz/dartz.dart';

import '../models/post.dart';

abstract class PostsRep {
  Future<Either<String, List<Post>>> getPosts();

  Future<List<Post>> getSavedPosts();
}
