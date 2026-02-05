import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';
import 'package:vsi_assessment/features/placeholder/domain/entities/post.dart';

import 'cubit/selected_post_cubit.dart';
import 'widgets/post_detail_body.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedPostCubit, Post?>(
      builder: (context, post) {
        if (post == null) {
          return AppScaffold(
            appBar: CommonAppBar(
              title: 'Post',
              automaticallyImplyLeading: true,
            ),
            body: const Center(child: Text('Post not found')),
          );
        }
        return PostDetailBody(post: post);
      },
    );
  }
}

