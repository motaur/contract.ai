import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock_recents.dart';
import '../models/recent.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';
import '../widgets/recent_row.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final groups = <String, List<Recent>>{};
    for (final r in mockHistory) {
      final g = r.group ?? 'Other';
      (groups[g] ??= []).add(r);
    }

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
                color: t.ink,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${mockHistory.length} contracts reviewed',
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
              decoration: BoxDecoration(
                color: t.card,
                border: Border.all(color: t.hair),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  AppIcons.search(t.muted, 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: 'Search contracts',
                        hintStyle: TextStyle(color: t.muted, fontSize: 14),
                      ),
                      style: TextStyle(fontSize: 14, color: t.ink),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            ...groups.entries.expand((e) => [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      e.key.toUpperCase(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: t.muted,
                      ),
                    ),
                  ),
                  ...e.value.map((r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: RecentRow(r: r, onTap: () => context.go('/results')),
                      )),
                  const SizedBox(height: 14),
                ]),
          ],
        ),
      ),
    );
  }
}
