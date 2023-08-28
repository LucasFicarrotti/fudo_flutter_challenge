import 'package:fudo_flutter_challenge/src/common/domain/repositories/toast_service.dart';
import 'package:fudo_flutter_challenge/src/posts/domain/repositories/posts_rep.dart';
import 'package:fudo_flutter_challenge/src/users/domain/repositories/users_rep.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';

import 'register_services_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<UsersRep>(),
    MockSpec<PostsRep>(),
    MockSpec<ToastService>(),
  ],
)
class RegisterServicesTest {
  static Future<void> register() async {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<UsersRep>(() => MockUsersRep());
    getIt.registerLazySingleton<PostsRep>(() => MockPostsRep());
    getIt.registerSingleton<ToastService>(MockToastService());
  }

  static Future<void> deregister() => GetIt.I.reset();
}
