import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/src/common/domain/repositories/toast_service.dart';
import 'package:get_it/get_it.dart';

import '../../domain/models/user.dart';
import '../../domain/repositories/users_rep.dart';

part 'users_state.dart';
part 'users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final _usersRep = GetIt.I.get<UsersRep>();
  final _toastService = GetIt.I.get<ToastService>();
  UsersBloc() : super(NotInitialized()) {
    on<Initialize>(_initialize);
    on<RefreshPage>(_refreshPage);
  }

  void _initialize(Initialize event, Emitter<UsersState> emit) async {
    final resultGetUsers = await _usersRep.getUsers();

    await resultGetUsers.fold(
      (errorMessage) async {
        _toastService.error(title: errorMessage);
        final users = await _usersRep.getSavedUsers();

        emit(
          Initialized(users: users),
        );
      },
      (users) {
        emit(
          Initialized(users: users),
        );
      },
    );
  }

  void _refreshPage(RefreshPage event, Emitter<UsersState> emit) {
    emit(NotInitialized());
    add(Initialize());
  }
}
