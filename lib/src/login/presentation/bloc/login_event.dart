part of 'login_bloc.dart';

abstract class LoginEvent {}

class Initialize extends LoginEvent {}

class ValidateLogin extends LoginEvent {
  final String user, password;

  ValidateLogin({
    required this.user,
    required this.password,
  });
}
