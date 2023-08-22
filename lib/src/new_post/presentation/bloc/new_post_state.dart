part of 'new_post_bloc.dart';

abstract class NewPostState {}

class NotInitialized extends NewPostState {}

class Initialized extends NewPostState {
  final bool postPublishOk;

  Initialized({this.postPublishOk = false});
}
