import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudo_flutter_challenge/core/routes/route_names.dart';
import 'package:fudo_flutter_challenge/src/common/presentation/widgets/empty_content.dart';
import 'package:fudo_flutter_challenge/src/common/presentation/widgets/loading_widget.dart';
import 'package:fudo_flutter_challenge/src/posts/presentation/bloc/posts_bloc.dart';

import '../widgets/post_card.dart';

class Posts extends StatelessWidget {
  const Posts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state is Initialized) {
            return _postsBody(context, state);
          } else {
            return _postsLoading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(RouteNames.newPost),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(200),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _postsBody(BuildContext context, Initialized state) {
    return state.posts.isNotEmpty
        ? RefreshIndicator(
            onRefresh: () async =>
                BlocProvider.of<PostsBloc>(context).add(RefreshPage()),
            child: ListView.builder(
              itemBuilder: (context, i) {
                final post = state.posts[i];
                return PostCard(post: post);
              },
              itemCount: state.posts.length,
            ),
          )
        : EmptyContent(
            onRefresh: () async =>
                BlocProvider.of<PostsBloc>(context).add(RefreshPage()),
            text: 'No hay posts para mostrar en este momento.',
          );
  }

  Widget _postsLoading() {
    return const LoadingWidget(message: 'Cargando posts...');
  }
}
