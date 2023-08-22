import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/core/routes/route_names.dart';
import 'package:fudo_flutter_challenge/src/home/presentation/bloc/home_bloc.dart'
    as home_bloc;
import 'package:fudo_flutter_challenge/src/home/presentation/pages/home.dart';
import 'package:fudo_flutter_challenge/src/login/presentation/bloc/login_bloc.dart'
    as login_bloc;
import 'package:fudo_flutter_challenge/src/login/presentation/pages/login.dart';
import 'package:fudo_flutter_challenge/src/new_post/presentation/pages/new_post.dart';
import 'package:fudo_flutter_challenge/src/posts/presentation/bloc/posts_bloc.dart'
    as posts_bloc;
import 'package:fudo_flutter_challenge/src/posts/presentation/pages/posts.dart';
import 'package:fudo_flutter_challenge/src/users/presentation/bloc/users_bloc.dart'
    as users_bloc;
import 'package:fudo_flutter_challenge/src/users/presentation/pages/users.dart';

import '../../src/new_post/presentation/bloc/new_post_bloc.dart' as new_post_bloc;

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.login:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.login),
          builder: (_) => BlocProvider<login_bloc.LoginBloc>(
            create: (context) =>
                login_bloc.LoginBloc()..add(login_bloc.Initialize()),
            child: const Login(),
          ),
        );

      case RouteNames.home:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.home),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<home_bloc.HomeBloc>(
                create: (context) => home_bloc.HomeBloc(),
              ),
              BlocProvider<users_bloc.UsersBloc>(
                create: (context) =>
                    users_bloc.UsersBloc()..add(users_bloc.Initialize()),
              ),
              BlocProvider<posts_bloc.PostsBloc>(
                create: (context) =>
                    posts_bloc.PostsBloc()..add(posts_bloc.Initialize()),
              ),
            ],
            child: const Home(),
          ),
        );

      case RouteNames.users:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.users),
          builder: (_) => BlocProvider<users_bloc.UsersBloc>(
            create: (context) => users_bloc.UsersBloc()
              ..add(
                users_bloc.Initialize(),
              ),
            child: const Users(),
          ),
        );
      case RouteNames.posts:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.posts),
          builder: (_) => BlocProvider<posts_bloc.PostsBloc>(
            create: (context) => posts_bloc.PostsBloc()
              ..add(
                posts_bloc.Initialize(),
              ),
            child: const Posts(),
          ),
        );
      case RouteNames.newPost:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.newPost),
          builder: (_) => BlocProvider<new_post_bloc.NewPostBloc>(
            create: (context) => new_post_bloc.NewPostBloc()
              ..add(
                new_post_bloc.Initialize(),
              ),
            child: const NewPost(),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: RouteNames.login),
          builder: (_) => BlocProvider<login_bloc.LoginBloc>(
            create: (context) =>
                login_bloc.LoginBloc()..add(login_bloc.Initialize()),
            child: const Login(),
          ),
        );
    }
  }
}
