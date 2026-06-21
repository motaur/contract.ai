import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/tokens.dart';
import 'app_icons.dart';

enum AppTab { home, history, settings }

class AppTabBar extends StatelessWidget {
  final AppTab active;
  const AppTabBar({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Container(
      decoration: BoxDecoration(
        color: t.card.withValues(alpha: 0.96),
        border: Border(top: BorderSide(color: t.hair)),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 28, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _tab(
            context,
            t,
            tab: AppTab.home,
            label: 'Home',
            iconBuilder: (c) => AppIcons.home(c, 24),
            path: '/home',
          ),
          _tab(
            context,
            t,
            tab: AppTab.history,
            label: 'History',
            iconBuilder: (c) => AppIcons.history(c, 24),
            path: '/history',
          ),
          _tab(
            context,
            t,
            tab: AppTab.settings,
            label: 'You',
            iconBuilder: (c) => AppIcons.user(c, 24),
            path: '/settings',
          ),
        ],
      ),
    );
  }

  Widget _tab(
    BuildContext context,
    Tokens t, {
    required AppTab tab,
    required String label,
    required Widget Function(Color) iconBuilder,
    required String path,
  }) {
    final on = tab == active;
    final color = on ? t.accent : t.muted;
    return InkWell(
      onTap: () => context.go(path),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconBuilder(color),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: on ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
