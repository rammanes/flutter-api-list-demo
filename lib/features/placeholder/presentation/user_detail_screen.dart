import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/core/widgets/widgets.dart';
import 'package:vsi_assessment/features/placeholder/domain/entities/user.dart';

import 'cubit/selected_user_cubit.dart';
import 'widgets/user_detail_body.dart';

class UserDetailScreen extends StatelessWidget {
  const UserDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectedUserCubit, User?>(
      builder: (context, user) {
        if (user == null) {
          return AppScaffold(
            appBar: CommonAppBar(
              title: 'User',
              automaticallyImplyLeading: true,
            ),
            body: const Center(child: Text('User not found')),
          );
        }
        return UserDetailBody(user: user);
      },
    );
  }
}
