import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/mock_issues.dart';
import '../theme/theme_controller.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';
import '../widgets/severity.dart';

class IssueDetailScreen extends StatelessWidget {
  final String issueId;
  const IssueDetailScreen({super.key, required this.issueId});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final sevStyle = context.watch<ThemeController>().sevStyle;
    final issue = findIssue(issueId) ?? mockIssues.first;
    final c = sevColor(t, issue.sev);

    return Stack(
      children: [
        Column(
          children: [
            _Header(t: t),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(22, 20, 22, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SevChip(kind: issue.sev, style: sevStyle),
                    const SizedBox(height: 14),
                    Text(
                      issue.title,
                      style: TextStyle(
                        fontSize: 26,
                        height: 30 / 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.6,
                        color: t.ink,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Found on page ${issue.page} · Clause 7.2',
                      style: TextStyle(fontSize: 13, color: t.muted),
                    ),
                    const SizedBox(height: 22),
                    _Section(
                      label: 'What the contract says',
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: t.bg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border(left: BorderSide(color: c.fg, width: 3)),
                        ),
                        child: Text(
                          '"${issue.snippet}"',
                          style: TextStyle(
                            fontSize: 14,
                            height: 21 / 14,
                            fontStyle: FontStyle.italic,
                            color: t.ink,
                          ),
                        ),
                      ),
                    ),
                    _Section(
                      label: 'Why it matters',
                      child: Text(
                        issue.why,
                        style: TextStyle(
                          fontSize: 15,
                          height: 23 / 15,
                          color: t.ink,
                        ),
                      ),
                    ),
                    if (issue.action != null)
                      _Section(
                        label: 'Suggested action',
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: t.accentSoft,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppIcons.sparkle(t.accent, 18),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  issue.action!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 21 / 14,
                                    color: t.accentDeep,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(child: _ShowInDocBtn()),
                        const SizedBox(width: 10),
                        Expanded(child: _FollowupBtn()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Floating prev/next pill
        Positioned(
          left: 20,
          right: 20,
          bottom: 28,
          child: _PrevNextBar(onNext: () => context.go('/results')),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final Tokens t;
  const _Header({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, MediaQuery.paddingOf(context).top + 12, 20, 14),
      decoration: BoxDecoration(
        color: t.card,
        border: Border(bottom: BorderSide(color: t.hair)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.go('/results'),
            borderRadius: BorderRadius.circular(999),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: AppIcons.back(t.ink, 22),
            ),
          ),
          const Spacer(),
          Text(
            'Issue 1 of 3',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: t.muted,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: AppIcons.more(t.ink, 22),
            splashRadius: 18,
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String label;
  final Widget child;
  const _Section({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: t.muted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _ShowInDocBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.card,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            border: Border.all(color: t.hair),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.eye(t.ink2, 16),
              const SizedBox(width: 6),
              Text(
                'Show in doc',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: t.ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowupBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.ink,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          child: Text(
            'Ask follow-up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: t.bg,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrevNextBar extends StatelessWidget {
  final VoidCallback onNext;
  const _PrevNextBar({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: t.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: t.hair),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 30,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              color: t.bg,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppIcons.back(t.ink, 16),
                      const SizedBox(width: 4),
                      Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Material(
              color: t.accent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: onNext,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      AppIcons.chevR(Colors.white, 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
