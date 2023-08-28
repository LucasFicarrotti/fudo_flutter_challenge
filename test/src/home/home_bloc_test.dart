import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_flutter_challenge/src/home/presentation/bloc/home_bloc.dart';

void main() {
  test(
    'Initial state is [HomeInitialized] with tabIndex 0',
    () async {
      final bloc = HomeBloc();
      expect(
        bloc.state,
        isA<HomeInitialized>().having((state) => state.tabIndex, 'tabIndex', 0),
      );
    },
  );

  blocTest<HomeBloc, HomeState>(
    'emits [HomeInitialized] when TabChange is added.',
    build: () => HomeBloc(),
    act: (bloc) => bloc.add(TabChange(tabIndex: 1)),
    expect: () => [
      isA<HomeInitialized>().having((state) => state.tabIndex, 'tabIndex', 1)
    ],
  );
}
