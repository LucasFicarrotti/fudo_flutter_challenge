part of 'home_bloc.dart';

abstract class HomeEvent {}



class TabChange extends HomeEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
