import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/mock_recents.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';
import '../widgets/recent_row.dart';
import 'upload_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tuesday · May 19',
                          style: TextStyle(fontSize: 14, color: t.muted)),
                      const SizedBox(height: 2),
                      Text(
                        'Hi, Sarah',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          color: t.ink,
                        ),
                      ),
                    ],
                  ),
                ),
                _AvatarBtn(onTap: () => context.go('/settings')),
              ],
            ),
            const SizedBox(height: 24),
            // Hero CTA
            _HeroCard(onTap: () => UploadSheet.show(context)),
            const SizedBox(height: 20),
            // Stats
            Row(
              children: [
                Expanded(child: _StatCard(n: '12', label: 'Reviewed')),
                const SizedBox(width: 10),
                Expanded(child: _StatCard(n: '3', label: 'Red flags', color: t.red)),
                const SizedBox(width: 10),
                Expanded(child: _StatCard(n: '9', label: 'Watch-outs', color: t.amber)),
              ],
            ),
            const SizedBox(height: 28),
            // Recent header
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Recent',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => context.go('/history'),
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: t.accent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...mockRecents.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: RecentRow(r: r, onTap: () => context.go('/results')),
                )),
          ],
        ),
      ),
    );
  }
}

class _AvatarBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _AvatarBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.accentSoft,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 42,
          height: 42,
          alignment: Alignment.center,
          child: Text(
            'SK',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: t.accent,
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final VoidCallback onTap;
  const _HeroCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      borderRadius: BorderRadius.circular(24),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [t.accent, t.accentDeep],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: t.accent.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Opacity(
                  opacity: 0.15,
                  child: AppIcons.logo(Colors.white, 140),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcons.sparkle(Colors.white, 12),
                        const SizedBox(width: 6),
                        const Text(
                          'Powered by AI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Analyze a contract',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 28 / 24,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const SizedBox(
                    width: 240,
                    child: Text(
                      'Drop a PDF, snap a photo, or paste the text.',
                      style: TextStyle(
                        color: Color(0xD9FFFFFF),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcons.upload(t.accentDeep, 16),
                        const SizedBox(width: 8),
                        Text(
                          'Choose source',
                          style: TextStyle(
                            color: t.accentDeep,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String n;
  final String label;
  final Color? color;
  const _StatCard({required this.n, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: t.card,
        border: Border.all(color: t.hair),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            n,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
              color: color ?? t.ink,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: TextStyle(fontSize: 11, color: t.muted)),
        ],
      ),
    );
  }
}
