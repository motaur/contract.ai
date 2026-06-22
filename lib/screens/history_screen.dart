import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controllers/analysis_controller.dart';
import '../models/history_entry.dart';
import '../models/recent.dart';
import '../services/prefs.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';
import '../widgets/recent_row.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<HistoryEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = Prefs.loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return SafeArea(
      bottom: false,
      child: FutureBuilder<List<HistoryEntry>>(
        future: _future,
        builder: (context, snap) {
          final history = snap.data ?? [];
          final groups = <String, List<HistoryEntry>>{};
          for (final e in history) {
            (groups[e.group] ??= []).add(e);
          }

          return SingleChildScrollView(
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
                  '${history.length} contracts reviewed',
                  style: TextStyle(fontSize: 14, color: t.muted),
                ),
                const SizedBox(height: 18),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
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
                            hintStyle:
                                TextStyle(color: t.muted, fontSize: 14),
                          ),
                          style: TextStyle(fontSize: 14, color: t.ink),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                if (history.isEmpty && snap.connectionState == ConnectionState.done)
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Text(
                        'No contracts analyzed yet.',
                        style: TextStyle(fontSize: 14, color: t.muted),
                      ),
                    ),
                  )
                else
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
                        ...e.value.map((entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: RecentRow(
                                r: Recent(
                                  id: entry.id,
                                  name: entry.fileName,
                                  when: entry.when,
                                  red: entry.red,
                                  amber: entry.amber,
                                  blue: entry.blue,
                                ),
                                onTap: () {
                                  context
                                      .read<AnalysisController>()
                                      .loadEntry(entry);
                                  context.go('/results');
                                },
                              ),
                            )),
                        const SizedBox(height: 14),
                      ]),
              ],
            ),
          );
        },
      ),
    );
  }
}
