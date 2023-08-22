import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/src/home/presentation/bloc/home_bloc.dart';
import 'package:fudo_flutter_challenge/src/home/presentation/widgets/app_drawer.dart';
import 'package:fudo_flutter_challenge/src/posts/presentation/pages/posts.dart';
import 'package:fudo_flutter_challenge/src/users/presentation/pages/users.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(elevation: 2),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitialized) {
              if (state.tabIndex == 0) {
                return const Users();
              } else if (state.tabIndex == 1) {
                return const Posts();
              }
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitialized) {
              return BottomNavigationBar(
                currentIndex: state.tabIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded),
                    label: 'users',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list_rounded),
                    label: 'posts',
                  )
                ],
                onTap: (index) => BlocProvider.of<HomeBloc>(context).add(
                  TabChange(tabIndex: index),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
