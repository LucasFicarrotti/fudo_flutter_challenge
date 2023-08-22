part of 'posts_bloc.dart';

abstract class PostsState {}

class NotInitialized extends PostsState {}

class Initialized extends PostsState {
  final List<Post> posts;

  Initialized({required this.posts});
}

class Error extends PostsState {
  final String message;

  Error({required this.message});
}
