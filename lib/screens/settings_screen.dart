import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../theme/theme_controller.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final controller = context.watch<ThemeController>();
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
                color: t.ink,
              ),
            ),
            const SizedBox(height: 22),
            _ProfileCard(),
            const SizedBox(height: 14),
            _PlanCard(),
            const SizedBox(height: 22),

            // Tweaks (replaces the design-canvas Tweaks panel)
            _SectionLabel(text: 'Tweaks'),
            _CardGroup(children: [
              _TweakRow(
                label: 'Accent color',
                trailing: _AccentSwatches(
                  selected: controller.accent,
                  onSelect: controller.setAccent,
                ),
              ),
              _TweakRow(
                label: 'Dark mode',
                trailing: Switch.adaptive(
                  value: controller.dark,
                  onChanged: controller.setDark,
                  activeThumbColor: t.accent,
                ),
              ),
              _TweakRow(
                label: 'Severity chips',
                trailing: SegmentedButton<SevStyle>(
                  segments: const [
                    ButtonSegment(value: SevStyle.soft, label: Text('Soft')),
                    ButtonSegment(value: SevStyle.solid, label: Text('Solid')),
                  ],
                  selected: {controller.sevStyle},
                  onSelectionChanged: (s) => controller.setSevStyle(s.first),
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    textStyle: WidgetStateProperty.all(
                      const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ]),

            const SizedBox(height: 18),
            _SectionLabel(text: 'Preferences'),
            _CardGroup(children: const [
              _SettingRow(label: 'Notifications', value: 'On'),
              _SettingRow(label: 'Severity labels', value: 'Red flags / Watch-outs / FYI'),
              _SettingRow(label: 'Language', value: 'English (US)'),
              _SettingRow(label: 'Appearance', value: 'System'),
            ]),

            const SizedBox(height: 18),
            _SectionLabel(text: 'Privacy'),
            _CardGroup(children: const [
              _SettingRow(label: 'Auto-delete after 30 days', value: 'On'),
              _SettingRow(label: 'Allow analytics', value: 'Off'),
              _SettingRow(label: 'Export my data'),
            ]),

            const SizedBox(height: 18),
            _SectionLabel(text: 'About'),
            _CardGroup(children: const [
              _SettingRow(label: 'Help & support'),
              _SettingRow(label: 'Terms of service'),
              _SettingRow(label: 'Privacy policy'),
            ]),

            const SizedBox(height: 4),
            _SignOutBtn(),
            const SizedBox(height: 18),
            Center(
              child: Text(
                'contract.ai · v0.1.0 (MVP)',
                style: TextStyle(fontSize: 11, color: t.muted),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: t.card,
        border: Border.all(color: t.hair),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: t.accentSoft, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('SK', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: t.accent)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sarah Kim', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: t.ink)),
                const SizedBox(height: 2),
                Text('sarah@kim.co', style: TextStyle(fontSize: 13, color: t.muted)),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: t.ink,
              side: BorderSide(color: t.hair),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [t.accent, t.accentDeep],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            right: -10,
            bottom: -20,
            child: Opacity(opacity: 0.18, child: AppIcons.sparkle(Colors.white, 100)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FREE PLAN',
                style: TextStyle(
                  color: Color(0xD9FFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                '3 of 5 contracts used',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Upgrade for unlimited reviews & priority models.',
                style: TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
              ),
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(99),
                child: LinearProgressIndicator(
                  value: 0.6,
                  minHeight: 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              const SizedBox(height: 14),
              Material(
                color: Colors.white,
                shape: const StadiumBorder(),
                child: InkWell(
                  customBorder: const StadiumBorder(),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    child: Text(
                      'Upgrade to Pro · \$9/mo',
                      style: TextStyle(
                        color: t.accentDeep,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});
  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: t.muted,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _CardGroup extends StatelessWidget {
  final List<Widget> children;
  const _CardGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final divided = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      divided.add(children[i]);
      if (i < children.length - 1) {
        divided.add(Divider(height: 1, thickness: 1, color: t.hair));
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: t.card,
        border: Border.all(color: t.hair),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(children: divided),
      ),
    );
  }
}

class _TweakRow extends StatelessWidget {
  final String label;
  final Widget trailing;
  const _TweakRow({required this.label, required this.trailing});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontSize: 15, color: t.ink))),
          trailing,
        ],
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  final String label;
  final String? value;
  const _SettingRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        child: Row(
          children: [
            Expanded(child: Text(label, style: TextStyle(fontSize: 15, color: t.ink))),
            if (value != null)
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(value!, style: TextStyle(fontSize: 13, color: t.muted)),
              ),
            AppIcons.chevR(t.muted, 14),
          ],
        ),
      ),
    );
  }
}

class _AccentSwatches extends StatelessWidget {
  final Color selected;
  final ValueChanged<Color> onSelect;
  const _AccentSwatches({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final c in ThemeController.accentSwatches) ...[
          _Swatch(color: c, selected: c.toARGB32() == selected.toARGB32(), onTap: () => onSelect(c)),
          const SizedBox(width: 6),
        ],
      ],
    );
  }
}

class _Swatch extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;
  const _Swatch({required this.color, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            if (selected)
              BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 6, spreadRadius: 1),
          ],
        ),
      ),
    );
  }
}

class _SignOutBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => context.go('/'),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: t.hair),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            'Sign out',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: t.red,
            ),
          ),
        ),
      ),
    );
  }
}
