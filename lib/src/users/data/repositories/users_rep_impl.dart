import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fudo_flutter_challenge/src/users/domain/models/user.dart';
import 'package:fudo_flutter_challenge/src/users/domain/repositories/users_rep.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsersRepImpl implements UsersRep {
  @override
  Future<Either<String, List<User>>> getUsers() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        final List<User> userList = <User>[];
        final jsonData = json.decode(response.body);
        final pref = await SharedPreferences.getInstance();

        for (var data in jsonData) {
          final user = User.fromJson(data);
          userList.add(user);
        }

        List<String> usersStringList =
            userList.map((user) => jsonEncode(user.toJson())).toList();
        pref.setStringList('users', usersStringList);

        return Right(userList);
      } else {
        return const Left('No se pudieron obtener los usuarios');
      }
    } catch (e) {
      return const Left('No se pudieron obtener los usuarios');
    }
  }

  @override
  Future<List<User>> getSavedUsers() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final usersList = (pref.getStringList('users') ?? []);
    List<User> users =
        usersList.map((user) => User.fromJson(jsonDecode(user))).toList();
    return users;
  }
}
