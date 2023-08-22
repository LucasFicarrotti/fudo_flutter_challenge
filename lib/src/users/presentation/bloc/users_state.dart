part of 'users_bloc.dart';

abstract class UsersState {}

class NotInitialized extends UsersState {}

class Initialized extends UsersState {
  final List<User> users;

  Initialized({required this.users});
}
