import 'package:flutter/material.dart';

/// Color tokens mirroring claude_design/contract.ai/screens.jsx.
/// Two palettes (light + dark) are switched via [Tokens.of].
class Tokens {
  final Color accent;
  final Color accentDeep;
  final Color accentSoft;
  final Color bg;
  final Color card;
  final Color ink;
  final Color ink2;
  final Color muted;
  final Color hair;
  final Color red;
  final Color redSoft;
  final Color redInk;
  final Color amber;
  final Color amberSoft;
  final Color amberInk;
  final Color blue;
  final Color blueSoft;
  final Color blueInk;
  final Color green;

  const Tokens({
    required this.accent,
    required this.accentDeep,
    required this.accentSoft,
    required this.bg,
    required this.card,
    required this.ink,
    required this.ink2,
    required this.muted,
    required this.hair,
    required this.red,
    required this.redSoft,
    required this.redInk,
    required this.amber,
    required this.amberSoft,
    required this.amberInk,
    required this.blue,
    required this.blueSoft,
    required this.blueInk,
    required this.green,
  });

  static const light = Tokens(
    accent: Color(0xFFD97757),
    accentDeep: Color(0xFFB85A3E),
    accentSoft: Color(0xFFFBE9DF),
    bg: Color(0xFFFAF7F2),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1F1A16),
    ink2: Color(0xFF4A4039),
    muted: Color(0xFF8A807A),
    hair: Color(0xFFECE6DD),
    red: Color(0xFFDC2626),
    redSoft: Color(0xFFFDECEC),
    redInk: Color(0xFF7F1D1D),
    amber: Color(0xFFD97706),
    amberSoft: Color(0xFFFDF3DF),
    amberInk: Color(0xFF78350F),
    blue: Color(0xFF3B82F6),
    blueSoft: Color(0xFFE8EFFF),
    blueInk: Color(0xFF1E3A8A),
    green: Color(0xFF0DAC81),
  );

  static const dark = Tokens(
    accent: Color(0xFFE89373),
    accentDeep: Color(0xFFD97757),
    accentSoft: Color(0xFF3A221A),
    bg: Color(0xFF161311),
    card: Color(0xFF211C19),
    ink: Color(0xFFF5EFE8),
    ink2: Color(0xFFCFC6BC),
    muted: Color(0xFF8A807A),
    hair: Color(0xFF2C2521),
    red: Color(0xFFF87171),
    redSoft: Color(0xFF3A1A1A),
    redInk: Color(0xFFFCA5A5),
    amber: Color(0xFFFBBF24),
    amberSoft: Color(0xFF3A2810),
    amberInk: Color(0xFFFCD34D),
    blue: Color(0xFF60A5FA),
    blueSoft: Color(0xFF1A2640),
    blueInk: Color(0xFFBFDBFE),
    green: Color(0xFF13BE90),
  );

  Tokens copyWith({Color? accent}) => Tokens(
        accent: accent ?? this.accent,
        accentDeep: accentDeep,
        accentSoft: accentSoft,
        bg: bg,
        card: card,
        ink: ink,
        ink2: ink2,
        muted: muted,
        hair: hair,
        red: red,
        redSoft: redSoft,
        redInk: redInk,
        amber: amber,
        amberSoft: amberSoft,
        amberInk: amberInk,
        blue: blue,
        blueSoft: blueSoft,
        blueInk: blueInk,
        green: green,
      );

  static Tokens of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<_TokensScope>();
    assert(inherited != null, 'No TokensScope found in widget tree');
    return inherited!.tokens;
  }
}

/// Inherited widget exposing the active [Tokens] to descendants.
class TokensScope extends StatelessWidget {
  final Tokens tokens;
  final Widget child;
  const TokensScope({super.key, required this.tokens, required this.child});

  @override
  Widget build(BuildContext context) =>
      _TokensScope(tokens: tokens, child: child);
}

class _TokensScope extends InheritedWidget {
  final Tokens tokens;
  const _TokensScope({required this.tokens, required super.child});

  @override
  bool updateShouldNotify(_TokensScope old) => old.tokens != tokens;
}

/// Soft (default) or solid severity chip rendering.
enum SevStyle { soft, solid }

enum SevKind { red, amber, blue }

class SevPalette {
  final Color fg;
  final Color bg;
  final Color ink;
  const SevPalette(this.fg, this.bg, this.ink);
}

SevPalette sevColor(Tokens t, SevKind k) {
  switch (k) {
    case SevKind.red:
      return SevPalette(t.red, t.redSoft, t.redInk);
    case SevKind.amber:
      return SevPalette(t.amber, t.amberSoft, t.amberInk);
    case SevKind.blue:
      return SevPalette(t.blue, t.blueSoft, t.blueInk);
  }
}

String sevLabel(SevKind k) {
  switch (k) {
    case SevKind.red:
      return 'Red flag';
    case SevKind.amber:
      return 'Watch-out';
    case SevKind.blue:
      return 'FYI';
  }
}
