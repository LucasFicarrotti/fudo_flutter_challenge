part of 'new_post_bloc.dart';

abstract class NewPostEvent {}

class Initialize extends NewPostEvent {}

class PublishNewPost extends NewPostEvent {
  final String title;
  final String content;

  PublishNewPost({
    required this.title,
    required this.content,
  });
}
