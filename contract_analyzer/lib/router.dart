import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/analyzing_screen.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/issue_detail_screen.dart';
import 'screens/results_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'theme/tokens.dart';
import 'widgets/app_tab_bar.dart';
import 'widgets/phone_frame.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => _RootShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => const SplashScreen(),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: _TabbedShell(tab: AppTab.home, child: HomeScreen())),
        ),
        GoRoute(
          path: '/history',
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: _TabbedShell(tab: AppTab.history, child: HistoryScreen())),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (_, __) =>
              const NoTransitionPage(child: _TabbedShell(tab: AppTab.settings, child: SettingsScreen())),
        ),
        GoRoute(
          path: '/analyzing',
          builder: (_, __) => const AnalyzingScreen(),
        ),
        GoRoute(
          path: '/results',
          builder: (_, __) => const ResultsScreen(),
        ),
        GoRoute(
          path: '/issue/:id',
          builder: (_, state) =>
              IssueDetailScreen(issueId: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
);

/// Wraps every route in [PhoneFrame] (only takes effect on wide web viewports).
class _RootShell extends StatelessWidget {
  final Widget child;
  const _RootShell({required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF0EEE9),
      body: PhoneFrame(
        child: ColoredBox(color: t.bg, child: child),
      ),
    );
  }
}

/// Wraps tabbed screens (Home/History/Settings) so the bottom tab bar
/// renders consistently and only those routes keep the bar.
class _TabbedShell extends StatelessWidget {
  final Widget child;
  final AppTab tab;
  const _TabbedShell({required this.child, required this.tab});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AppTabBar(active: tab),
        ),
      ],
    );
  }
}
