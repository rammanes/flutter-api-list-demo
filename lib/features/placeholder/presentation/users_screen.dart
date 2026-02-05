import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/users_cubit.dart';
import 'cubit/users_state.dart';
import 'widgets/user_tile.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UsersInitial || state is UsersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is UsersLoaded) {
          final users = state.users;
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemBuilder: (context, index) {
              final user = users[index];
              return UserTile(
                user: user,
                onTap: () {},
              );
            },
          );
        }
        if (state is UsersError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(state.message),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.read<UsersCubit>().loadUsers(),
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
