part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitialized extends HomeState {
  final int tabIndex;
  HomeInitialized({required this.tabIndex});
}
