import 'package:bankingapp/features/home/presentation/pages/camera_page.dart';
import 'package:bankingapp/features/home/presentation/pages/home_page.dart';
import 'package:bankingapp/features/home/presentation/pages/nfc_reader.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';


class Routes {
  static String get splash => "/";
  static String get home => "/home";
  static String get camera => "/camera";
  static String get nfc => "/nfc";
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _sectionANavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class AppRoutes {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    routes: <RouteBase>[
      GoRoute(
          path: Routes.splash,
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen()),

      GoRoute(
          path: Routes.home,
          builder: (BuildContext context, GoRouterState state) {
            final data = state.extra as Map<String,dynamic>;
             final number = data["number"] as String;
             final date = data["date"] as String;
              return CardInputScreen(number: number,date: date,);
            }
      ),
      GoRoute(
          path: Routes.camera,
          builder: (BuildContext context, GoRouterState state) =>
               CameraScreen()),
      GoRoute(
          path: Routes.nfc,
          builder: (BuildContext context, GoRouterState state) =>
              MyHomePage()),

      // StatefulShellRoute.indexedStack(
      //   builder: (BuildContext context, GoRouterState state,
      //       StatefulNavigationShell navigationShell) {
      //     return MainPage(child: navigationShell);
      //   },
      //   branches: <StatefulShellBranch>[
      //     // StatefulShellBranch(
      //     //   navigatorKey: _sectionANavigatorKey,
      //     //   routes: <RouteBase>[
      //     //     GoRoute(
      //     //       path: Routes.home,
      //     //       name: Routes.home,
      //     //       pageBuilder: (BuildContext context, GoRouterState state) {
      //     //         return buildPageWithDefaultTransition<void>(
      //     //             context: context, state: state, child: HomePage()
      //     //             );
      //     //       },
      //     //     ),
      //     //   ],
      //     // ),
      //
      //
      //   ],
      // ),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
