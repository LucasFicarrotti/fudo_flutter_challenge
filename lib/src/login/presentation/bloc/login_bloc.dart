import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/src/common/domain/repositories/toast_service.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(NotInitialized()) {
    on<Initialize>(_initialize);
    on<ValidateLogin>(_validateLogin);
  }

  void _initialize(Initialize event, Emitter<LoginState> emit) {
    emit(Initialized(isAuthenticated: false));
  }

  void _validateLogin(ValidateLogin event, Emitter<LoginState> emit) {
    if (event.user == 'challenge@fudo' && event.password == 'password') {
      emit(Initialized(isAuthenticated: true));
    } else {
      ToastService().error(
        title: 'Usuario o clave incorrectos',
      );
      emit(
        Initialized(isAuthenticated: false),
      );
    }
  }
}
