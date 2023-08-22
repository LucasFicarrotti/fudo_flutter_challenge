import 'package:dartz/dartz.dart';

import '../models/user.dart';

abstract class UsersRep {
  Future<Either<String, List<User>>> getUsers();

  Future<List<User>> getSavedUsers();
}
