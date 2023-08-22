import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialized(tabIndex: 0)) {
    on<TabChange>(_tabChange);
  }

  void _tabChange(TabChange event, Emitter<HomeState> emit) {
    emit(HomeInitialized(tabIndex: event.tabIndex));
  }
}
