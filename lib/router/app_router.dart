import 'package:go_router/go_router.dart';

import 'package:vsi_assessment/features/books/presentation/books_screen.dart';
import 'package:vsi_assessment/features/characters/presentation/characters_screen.dart';
import 'package:vsi_assessment/features/main_shell.dart';
import 'package:vsi_assessment/features/posts/presentation/posts_screen.dart';
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
              builder: (context, state) => const PostsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/books',
              builder: (context, state) => const BooksScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/characters',
              builder: (context, state) => const CharactersScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
