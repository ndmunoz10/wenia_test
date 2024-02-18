import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:wenia_test/core/router/routes.dart';
import 'package:wenia_test/presentation/features/home/all/all_crypt_screen.dart';
import 'package:wenia_test/presentation/features/home/comparison/comparison_crypt_screen.dart';
import 'package:wenia_test/presentation/features/home/favorite/favorite_crypt_screen.dart';
import 'package:wenia_test/presentation/features/home/home_screen.dart';
import 'package:wenia_test/presentation/features/login/login_screen.dart';
import 'package:wenia_test/presentation/features/splash/splash_screen.dart';

final _rootNavigationKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigationKey,
  initialLocation: Routes.splashScreen,
  routes: [
    GoRoute(
      path: Routes.splashScreen,
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.loginScreen,
      builder: (_, __) => const LoginScreen(),
    ),
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.allCryptScreen,
              pageBuilder: (_, __) => const NoTransitionPage(child: AllCryptScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.favoriteCryptScreen,
              pageBuilder: (_, __) => NoTransitionPage(child: FavoriteCryptScreen()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.compareCryptScreen,
              pageBuilder: (_, __) => const NoTransitionPage(child: ComparisonCryptScreen()),
            ),
          ],
        ),
      ],
      builder: (_, __, statefulNavigationShell) => HomeScreen(
        statefulNavigationShell: statefulNavigationShell,
      ),
    ),
  ],
);
