import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/posts_cubit.dart';
import 'cubit/posts_state.dart';
import 'cubit/selected_post_cubit.dart';
import 'widgets/post_tile.dart';

/// Posts list content (used inside JSONPlaceholder tab).
class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
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
                  onTap: () {
                    context.read<SelectedPostCubit>().select(post);
                    context.push('/posts/post/${post.id}');
                  },
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
      );
  }
}

