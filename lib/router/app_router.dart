import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:vsi_assessment/features/books/data/repositories/books_repository_impl.dart';
import 'package:vsi_assessment/features/books/presentation/books_screen.dart';
import 'package:vsi_assessment/features/books/presentation/cubit/books_cubit.dart';
import 'package:vsi_assessment/features/characters/data/repositories/characters_repository_impl.dart';
import 'package:vsi_assessment/features/characters/presentation/characters_screen.dart';
import 'package:vsi_assessment/features/characters/presentation/cubit/characters_cubit.dart';
import 'package:vsi_assessment/features/main_shell.dart';
import 'package:vsi_assessment/features/placeholder/data/repositories/posts_repository_impl.dart';
import 'package:vsi_assessment/features/placeholder/data/repositories/users_repository_impl.dart';
import 'package:vsi_assessment/features/placeholder/presentation/cubit/posts_cubit.dart';
import 'package:vsi_assessment/features/placeholder/presentation/cubit/users_cubit.dart';
import 'package:vsi_assessment/features/placeholder/presentation/json_placeholder_screen.dart';
import 'package:vsi_assessment/features/splash/presentation/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/splash',
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainShell(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/posts',
              builder: (context, state) => MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        PostsCubit(PostsRepositoryImpl())..loadPosts(),
                  ),
                  BlocProvider(
                    create: (_) =>
                        UsersCubit(UsersRepositoryImpl())..loadUsers(),
                  ),
                ],
                child: const JsonPlaceholderScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/books',
              builder: (context, state) => BlocProvider(
                create: (_) => BooksCubit(BooksRepositoryImpl()),
                child: const BooksScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/characters',
              builder: (context, state) => BlocProvider(
                create: (_) =>
                    CharactersCubit(CharactersRepositoryImpl())..loadCharacters(),
                child: const CharactersScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
