import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../features/focus_mode/presentation/pages/focus_mode_page.dart';
import '../../features/history/presentation/pages/history_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/task_details/presentation/pages/task_details_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: HomePage.routeName,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, _, navigationShell) {
        return HomeScreen(navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: HomePage.routeName,
              builder: (_, _) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: HistoryPage.routeName,
              builder: (_, _) => const HistoryPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: FocusModePage.routeName,
      builder: (_, state) {
        final taskId = state.extra as String;
        return FocusModePage(taskId);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: TaskDetailsPage.routeName,
      builder: (_, state) {
        final taskId = state.extra as String;

        return TaskDetailsPage(taskId);
      },
    ),
  ],
);
