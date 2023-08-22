part of 'login_bloc.dart';

abstract class LoginState {}

class NotInitialized extends LoginState {}

class Initialized extends LoginState {
  final bool isAuthenticated;

  Initialized({required this.isAuthenticated});
}
