import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import 'cubit/posts_cubit.dart';
import 'cubit/posts_state.dart';
import 'widgets/post_tile.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CommonAppBar(title: 'Posts'),
      body: BlocBuilder<PostsCubit, PostsState>(
        builder: (context, state) {
          if (state is PostsInitial || state is PostsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PostsLoaded) {
            final posts = state.posts;
            return ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostTile(
                  post: post,
                  onTap: () {},
                );
              },
            );
          }
          if (state is PostsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.read<PostsCubit>().loadPosts(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

