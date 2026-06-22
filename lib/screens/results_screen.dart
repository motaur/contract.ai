import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controllers/analysis_controller.dart';
import '../data/mock_issues.dart';
import '../models/issue.dart';
import '../theme/theme_controller.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';
import '../widgets/severity.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  SevKind? _filter; // null = all

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final sevStyle = context.watch<ThemeController>().sevStyle;
    final ctrl = context.watch<AnalysisController>();
    final allIssues =
        ctrl.status == AnalysisStatus.done ? ctrl.issues : mockIssues;
    final filtered = _filter == null
        ? allIssues
        : allIssues.where((i) => i.sev == _filter).toList();
    final cntR = allIssues.where((i) => i.sev == SevKind.red).length;
    final cntA = allIssues.where((i) => i.sev == SevKind.amber).length;
    final cntB = allIssues.where((i) => i.sev == SevKind.blue).length;
    final summary = ctrl.status == AnalysisStatus.done
        ? ctrl.summary
        : 'Mostly fair, with 3 things to push back on. The auto-renewal and repair threshold stand out — both negotiable.';
    final docName = ctrl.status == AnalysisStatus.done
        ? ctrl.fileName
        : 'Apartment lease — 235 Bowery';
    final secs = ctrl.status == AnalysisStatus.done ? ctrl.durationSecs : 18;

    return Column(
      children: [
        _Header(
            t: t,
            cntR: cntR,
            cntA: cntA,
            cntB: cntB,
            filter: _filter,
            summary: summary,
            docName: docName,
            durationSecs: secs,
            onFilter: (v) => setState(() => _filter = v)),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 40),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) => _IssueCard(
              issue: filtered[i],
              chipStyle: sevStyle,
              onTap: () => context.go('/issue/${filtered[i].id}'),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final Tokens t;
  final int cntR;
  final int cntA;
  final int cntB;
  final SevKind? filter;
  final String summary;
  final String docName;
  final int durationSecs;
  final ValueChanged<SevKind?> onFilter;
  const _Header({
    required this.t,
    required this.cntR,
    required this.cntA,
    required this.cntB,
    required this.filter,
    required this.summary,
    required this.docName,
    required this.durationSecs,
    required this.onFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: t.card,
      padding: EdgeInsets.fromLTRB(20, MediaQuery.paddingOf(context).top + 12, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => context.go('/home'),
                borderRadius: BorderRadius.circular(999),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: AppIcons.back(t.ink, 22),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: AppIcons.share(t.ink, 20),
                    splashRadius: 18,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: AppIcons.more(t.ink, 22),
                    splashRadius: 18,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: t.accentSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: AppIcons.doc(t.accent, 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        color: t.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Reviewed in ${durationSecs}s',
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // AI summary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: t.accentSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: AppIcons.sparkle(t.accent, 16),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 13,
                        height: 19 / 13,
                        color: t.accentDeep,
                        fontFamily: 'Ploni',
                      ),
                      children: [
                        TextSpan(
                          text: summary,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _Chip(label: 'All ${cntR + cntA + cntB}', on: filter == null, onTap: () => onFilter(null)),
                const SizedBox(width: 6),
                _Chip(label: 'Red flags $cntR', on: filter == SevKind.red, dot: SevKind.red, onTap: () => onFilter(SevKind.red)),
                const SizedBox(width: 6),
                _Chip(label: 'Watch-outs $cntA', on: filter == SevKind.amber, dot: SevKind.amber, onTap: () => onFilter(SevKind.amber)),
                const SizedBox(width: 6),
                _Chip(label: 'FYI $cntB', on: filter == SevKind.blue, dot: SevKind.blue, onTap: () => onFilter(SevKind.blue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool on;
  final SevKind? dot;
  final VoidCallback onTap;
  const _Chip({required this.label, required this.on, this.dot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: on ? t.accent : t.card,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            border: Border.all(color: on ? t.accent : t.hair),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (dot != null) ...[
                SevDot(kind: dot!, size: 7),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: on ? Colors.white : t.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IssueCard extends StatelessWidget {
  final Issue issue;
  final SevStyle chipStyle;
  final VoidCallback onTap;
  const _IssueCard({required this.issue, required this.chipStyle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final c = sevColor(t, issue.sev);
    return Material(
      color: t.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(width: 4, color: c.fg),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: t.hair),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SevChip(kind: issue.sev, style: chipStyle, small: true),
                      const Spacer(),
                      Text(
                        'p. ${issue.page}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: t.muted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    issue.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 20 / 15,
                      letterSpacing: -0.2,
                      color: t.ink,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '"${issue.snippet}"',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      height: 19 / 13,
                      color: t.ink2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
