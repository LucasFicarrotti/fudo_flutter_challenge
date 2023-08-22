import 'package:fudo_flutter_challenge/src/common/domain/repositories/toast_service.dart';
import 'package:fudo_flutter_challenge/src/posts/domain/repositories/posts_rep.dart';
import 'package:fudo_flutter_challenge/src/users/data/repositories/users_rep_impl.dart';
import 'package:get_it/get_it.dart';

import '../../src/posts/data/repositories/posts_rep_impl.dart';
import '../../src/users/domain/repositories/users_rep.dart';

class RegisterServices {
  static Future<void> register() async {
    final getIt = GetIt.instance;

    getIt.registerLazySingleton<UsersRep>(() => UsersRepImpl());
    getIt.registerLazySingleton<PostsRep>(() => PostsRepImpl());
    getIt.registerSingleton<ToastService>(ToastService());
  }
}
