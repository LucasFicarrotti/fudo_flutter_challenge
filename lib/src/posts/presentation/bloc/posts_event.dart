part of 'posts_bloc.dart';

abstract class PostsEvent {}

class Initialize extends PostsEvent {}

class RefreshPage extends PostsEvent {}
