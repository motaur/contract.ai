import 'package:flutter/material.dart';

import '../theme/tokens.dart';

class PrimaryBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  const PrimaryBtn({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.accent,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: t.accent,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: t.accent.withValues(alpha: 0.2),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: DefaultTextStyle.merge(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class GhostBtn extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  const GhostBtn({
    super.key,
    required this.child,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: t.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: t.hair),
          ),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              color: t.ink,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
