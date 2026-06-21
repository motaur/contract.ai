import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/tokens.dart';
import '../widgets/app_icons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -1.0),
          radius: 0.95,
          colors: [t.accentSoft, t.bg],
          stops: const [0.0, 0.7],
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(28, 80, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: t.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: t.hair),
                      boxShadow: [
                        BoxShadow(
                          color: t.accent.withValues(alpha: 0.13),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: AppIcons.logo(t.accent, 32),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: t.ink,
                            fontFamily: 'Ploni',
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                          children: [
                            const TextSpan(text: 'contract'),
                            TextSpan(text: '.ai', style: TextStyle(color: t.accent)),
                          ],
                        ),
                      ),
                      // const SizedBox(height: 2),
                      // Text('by Morning', style: TextStyle(fontSize: 13, color: t.muted)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 56),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: t.ink,
                    fontFamily: 'Ploni',
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1.2,
                    height: 42 / 38,
                  ),
                  children: [
                    const TextSpan(text: 'Spot the fine print\n'),
                    TextSpan(text: 'in seconds.', style: TextStyle(color: t.accent)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 280),
                child: Text(
                  "Upload any contract — we'll flag what to watch for, in plain English.",
                  style: TextStyle(fontSize: 16, height: 22 / 16, color: t.ink2),
                ),
              ),
              const SizedBox(height: 120),
              _AppleBtn(onTap: () => context.go('/home')),
              const SizedBox(height: 10),
              _GoogleBtn(onTap: () => context.go('/home')),
              const SizedBox(height: 10),
              _EmailBtn(onTap: () => context.go('/home')),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'By continuing, you agree to our Terms and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: t.muted, height: 18 / 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppleBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _AppleBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.apple(Colors.white, 16),
              const SizedBox(width: 8),
              const Text(
                'Continue with Apple',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _GoogleBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: t.hair),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcons.google(18),
              const SizedBox(width: 8),
              Text(
                'Continue with Google',
                style: TextStyle(color: t.ink, fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmailBtn extends StatelessWidget {
  final VoidCallback onTap;
  const _EmailBtn({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.card,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: t.hair),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            'Continue with email',
            style: TextStyle(color: t.ink, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
