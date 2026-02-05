import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vsi_assessment/features/books/presentation/cubit/selected_book_cubit.dart';
import 'package:vsi_assessment/features/characters/presentation/cubit/selected_character_cubit.dart';
import 'package:vsi_assessment/features/placeholder/presentation/cubit/selected_post_cubit.dart';
import 'package:vsi_assessment/features/placeholder/presentation/cubit/selected_user_cubit.dart';
import 'package:vsi_assessment/router/app_router.dart';
import 'package:vsi_assessment/styles/app_theme.dart';

void main() {
  runApp(const VsiAssessment());
}

class VsiAssessment extends StatelessWidget {
  const VsiAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SelectedPostCubit()),
        BlocProvider(create: (_) => SelectedUserCubit()),
        BlocProvider(create: (_) => SelectedCharacterCubit()),
        BlocProvider(create: (_) => SelectedBookCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'VsiAssessment',
        theme: AppTheme.light,
        routerConfig: appRouter,
      ),
    );
  }
}

