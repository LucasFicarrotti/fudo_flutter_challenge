import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/src/common/presentation/widgets/empty_content.dart';
import 'package:fudo_flutter_challenge/src/common/presentation/widgets/loading_widget.dart';
import 'package:fudo_flutter_challenge/src/users/presentation/widgets/user_card.dart';

import '../bloc/users_bloc.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is Initialized) {
            return _usersBody(context, state);
          } else {
            return _usersLoading();
          }
        },
      ),
    );
  }

  Widget _usersBody(BuildContext context, Initialized state) {
    return state.users.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async =>
                BlocProvider.of<UsersBloc>(context).add(RefreshPage()),
            child: ListView.builder(
              itemBuilder: (context, i) {
                final user = state.users[i];
                return UserCard(user: user);
              },
              itemCount: state.users.length,
            ),
          )
        : EmptyContent(
            onRefresh: () async =>
                BlocProvider.of<UsersBloc>(context).add(RefreshPage()),
            text: 'No hay usuarios para mostrar en este momento.',
          );
  }

  Widget _usersLoading() {
    return const LoadingWidget(
      message: 'Cargando usuarios...',
    );
  }
}
