import 'package:flutter/material.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';

import 'posts_screen.dart';
import 'users_screen.dart';

class JsonPlaceholderScreen extends StatelessWidget {
  const JsonPlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AppScaffold(
        appBar: CommonAppBar(
          title: 'JSONPlaceholder',
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Users'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PostsScreen(),
            UsersScreen(),
          ],
        ),
      ),
    );
  }
}
