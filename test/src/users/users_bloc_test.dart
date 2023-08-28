import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_flutter_challenge/src/users/domain/models/user.dart';
import 'package:fudo_flutter_challenge/src/users/domain/repositories/users_rep.dart';
import 'package:fudo_flutter_challenge/src/users/presentation/bloc/users_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

import '../../register_services_test.dart';
import '../../register_services_test.mocks.dart';

void main() {
  group(
    'UsersBloc.Initialize',
    () {
      test(
        'Emits [NotInitialized] when bloc inits',
        () async {
          await RegisterServicesTest.register();
          final bloc = UsersBloc();
          expect(bloc.state, isA<NotInitialized>());
          await RegisterServicesTest.deregister();
        },
      );

      blocTest<UsersBloc, UsersState>(
        'emits [Initialized] when Initialize is added without errors.',
        build: () => UsersBloc(),
        act: (bloc) => bloc.add(Initialize()),
        setUp: () => _TestUtil.configRepository(getUserOk: true),
        tearDown: () async => await RegisterServicesTest.deregister(),
        expect: () => [
          isA<Initialized>().having(
            (state) => state.users.length,
            'users.length',
            2,
          ),
        ],
      );

      blocTest<UsersBloc, UsersState>(
        'emits [Initialized] with users saved in the local storage when Initialize is added with errors.',
        build: () => UsersBloc(),
        act: (bloc) => bloc.add(Initialize()),
        setUp: () => _TestUtil.configRepository(getUserOk: false),
        tearDown: () async => await RegisterServicesTest.deregister(),
        expect: () => [
          isA<Initialized>().having(
            (state) => state.users.length,
            'users.length',
            2,
          ),
        ],
      );
    },
  );

  group(
    'UsersBloc.RefreshPage',
    () {
      blocTest<UsersBloc, UsersState>(
        'emits [Initialized] when RefreshPage is added without errors.',
        build: () => UsersBloc(),
        act: (bloc) => bloc.add(RefreshPage()),
        setUp: () => _TestUtil.configRepository(getUserOk: true),
        tearDown: () async => await RegisterServicesTest.deregister(),
        expect: () => [
          isA<NotInitialized>(),
          isA<Initialized>().having(
            (state) => state.users.length,
            'users.length',
            2,
          ),
        ],
      );

      blocTest<UsersBloc, UsersState>(
        'emits [Initialized] when RefreshPage is added with errors.',
        build: () => UsersBloc(),
        act: (bloc) => bloc.add(RefreshPage()),
        setUp: () => _TestUtil.configRepository(getUserOk: false),
        tearDown: () async => await RegisterServicesTest.deregister(),
        expect: () => [
          isA<NotInitialized>(),
          isA<Initialized>().having(
            (state) => state.users.length,
            'users.length',
            2,
          ),
        ],
      );
    },
  );
}

class _TestUtil {
  static void configRepository({bool getUserOk = false}) async {
    await RegisterServicesTest.register();
    final mockUsersRep = GetIt.I.get(type: UsersRep) as MockUsersRep;
    final List<User> users = [
      User()
        ..id = 1
        ..name = "Leanne Graham"
        ..username = "Bret"
        ..website = "hildegard.org",
      User()
        ..id = 2
        ..name = "Ervin Howell"
        ..username = "Antonette"
        ..website = "anastasia.net",
    ];

    when(mockUsersRep.getUsers()).thenAnswer(
        (_) => Future.value(getUserOk ? Right(users) : const Left('Error')));
    when(mockUsersRep.getSavedUsers()).thenAnswer((_) => Future.value(users));
  }
}
