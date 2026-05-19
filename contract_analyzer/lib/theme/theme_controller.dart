import 'package:flutter/material.dart';
import 'tokens.dart';

/// Holds the user-controllable design tweaks: accent color, dark mode,
/// severity chip style. Mirrors the prototype's Tweaks panel.
class ThemeController extends ChangeNotifier {
  Color _accent = const Color(0xFFD97757);
  bool _dark = false;
  SevStyle _sevStyle = SevStyle.soft;

  Color get accent => _accent;
  bool get dark => _dark;
  SevStyle get sevStyle => _sevStyle;

  static const accentSwatches = <Color>[
    Color(0xFFD97757),
    Color(0xFF0A7D5A),
    Color(0xFF1F3A8A),
    Color(0xFF111111),
    Color(0xFF8D3DEB),
  ];

  void setAccent(Color c) {
    if (_accent == c) return;
    _accent = c;
    notifyListeners();
  }

  void setDark(bool v) {
    if (_dark == v) return;
    _dark = v;
    notifyListeners();
  }

  void setSevStyle(SevStyle s) {
    if (_sevStyle == s) return;
    _sevStyle = s;
    notifyListeners();
  }

  Tokens get tokens {
    final base = _dark ? Tokens.dark : Tokens.light;
    return base.copyWith(accent: _accent);
  }
}
