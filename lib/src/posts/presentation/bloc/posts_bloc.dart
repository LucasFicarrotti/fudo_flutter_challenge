import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../common/domain/repositories/toast_service.dart';
import '../../domain/models/post.dart';
import '../../domain/repositories/posts_rep.dart';

part 'posts_state.dart';
part 'posts_event.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final _postsRep = GetIt.I.get<PostsRep>();
  final _toastService = GetIt.I.get<ToastService>();
  PostsBloc() : super(NotInitialized()) {
    on<Initialize>(_initialize);
    on<RefreshPage>(_refreshPage);
  }

  void _initialize(Initialize event, Emitter<PostsState> emit) async {
    final resultGetPosts = await _postsRep.getPosts();

    await resultGetPosts.fold(
      (errorMessage) async {
        _toastService.error(title: errorMessage);
        final posts = await _postsRep.getSavedPosts();

        emit(
          Initialized(posts: posts),
        );
      },
      (posts) {
        emit(
          Initialized(posts: posts),
        );
      },
    );
  }

  void _refreshPage(RefreshPage event, Emitter<PostsState> emit) {
    emit(NotInitialized());
    add(Initialize());
  }
}
