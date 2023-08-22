import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/src/common/domain/repositories/toast_service.dart';
import 'package:get_it/get_it.dart';

part 'new_post_event.dart';
part 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent, NewPostState> {
  final _toastService = GetIt.I.get<ToastService>();

  NewPostBloc() : super(NotInitialized()) {
    on<Initialize>(_initialize);
    on<PublishNewPost>(_publishNewPost);
  }

  void _initialize(Initialize event, Emitter<NewPostState> emit) {
    emit(Initialized(postPublishOk: false));
  }

  void _publishNewPost(PublishNewPost event, Emitter<NewPostState> emit) async {
    _toastService.success(title: 'Su post fue subido con exito');

    emit(Initialized(postPublishOk: true));
  }
}
