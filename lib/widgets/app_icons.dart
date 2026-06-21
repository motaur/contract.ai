import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// SVG icon set mirroring the inline icons in claude_design/contract.ai/screens.jsx.
/// Each returns a [SvgPicture] sized to [size], stroked / filled with [color].
class AppIcons {
  static Widget _svg(String src, double size) => SvgPicture.string(
        src,
        width: size,
        height: size,
        fit: BoxFit.contain,
      );

  static String _hex(Color c) {
    final v = c.toARGB32() & 0xFFFFFF;
    return '#${v.toRadixString(16).padLeft(6, '0')}';
  }

  static Widget logo(Color c, [double size = 40]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40" fill="none">
  <rect x="6"  y="11" width="20" height="3" rx="1.5" fill="$hex" opacity="0.35"/>
  <rect x="6"  y="18.5" width="28" height="3" rx="1.5" fill="$hex"/>
  <rect x="6"  y="26" width="16" height="3" rx="1.5" fill="$hex" opacity="0.35"/>
  <circle cx="34" cy="20" r="3.5" fill="$hex"/>
</svg>''', size);
  }

  static Widget doc(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M6 3h8l4 4v14a1 1 0 01-1 1H6a1 1 0 01-1-1V4a1 1 0 011-1z" stroke="$hex" stroke-width="1.6"/>
  <path d="M14 3v4h4" stroke="$hex" stroke-width="1.6"/>
</svg>''', size);
  }

  static Widget upload(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M12 16V5m0 0l-4 4m4-4l4 4" stroke="$hex" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M5 17v2a2 2 0 002 2h10a2 2 0 002-2v-2" stroke="$hex" stroke-width="1.8" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget camera(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <rect x="3" y="7" width="18" height="13" rx="2" stroke="$hex" stroke-width="1.6"/>
  <circle cx="12" cy="13.5" r="3.5" stroke="$hex" stroke-width="1.6"/>
  <path d="M8 7l1.5-2h5L16 7" stroke="$hex" stroke-width="1.6"/>
</svg>''', size);
  }

  static Widget text(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M5 6h14M5 12h14M5 18h9" stroke="$hex" stroke-width="1.8" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget cloud(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M7 18a4 4 0 010-8 6 6 0 0111.5 1.5A3.5 3.5 0 0117 18H7z" stroke="$hex" stroke-width="1.6"/>
</svg>''', size);
  }

  static Widget search(Color c, [double size = 18]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <circle cx="11" cy="11" r="6.5" stroke="$hex" stroke-width="1.8"/>
  <path d="M16 16l4 4" stroke="$hex" stroke-width="1.8" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget home(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M4 11l8-7 8 7v8a2 2 0 01-2 2h-3v-6h-6v6H6a2 2 0 01-2-2v-8z" stroke="$hex" stroke-width="1.6" stroke-linejoin="round"/>
</svg>''', size);
  }

  static Widget history(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M4 12a8 8 0 108-8" stroke="$hex" stroke-width="1.6" stroke-linecap="round"/>
  <path d="M4 4v5h5" stroke="$hex" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M12 8v5l3 2" stroke="$hex" stroke-width="1.6" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget user(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <circle cx="12" cy="9" r="3.5" stroke="$hex" stroke-width="1.6"/>
  <path d="M5 20c1-3.5 4-5 7-5s6 1.5 7 5" stroke="$hex" stroke-width="1.6" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget back(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M14 6l-6 6 6 6" stroke="$hex" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''', size);
  }

  static Widget chevR(Color c, [double size = 18]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M9 6l6 6-6 6" stroke="$hex" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''', size);
  }

  static Widget close(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M6 6l12 12M18 6L6 18" stroke="$hex" stroke-width="2" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget more(Color c, [double size = 22]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <circle cx="5" cy="12" r="1.6" fill="$hex"/>
  <circle cx="12" cy="12" r="1.6" fill="$hex"/>
  <circle cx="19" cy="12" r="1.6" fill="$hex"/>
</svg>''', size);
  }

  static Widget share(Color c, [double size = 20]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M12 4v12m0-12l-4 4m4-4l4 4" stroke="$hex" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"/>
  <path d="M5 14v4a2 2 0 002 2h10a2 2 0 002-2v-4" stroke="$hex" stroke-width="1.7" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget check(Color c, [double size = 18]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M5 12l5 5L20 7" stroke="$hex" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''', size);
  }

  static Widget flag(Color c, [double size = 16]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M5 21V4h11l-2 4 2 4H5" stroke="$hex" stroke-width="1.8" stroke-linejoin="round"/>
</svg>''', size);
  }

  static Widget eye(Color c, [double size = 16]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M2 12s4-7 10-7 10 7 10 7-4 7-10 7S2 12 2 12z" stroke="$hex" stroke-width="1.6"/>
  <circle cx="12" cy="12" r="3" stroke="$hex" stroke-width="1.6"/>
</svg>''', size);
  }

  static Widget info(Color c, [double size = 16]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <circle cx="12" cy="12" r="9" stroke="$hex" stroke-width="1.6"/>
  <path d="M12 11v6M12 7.5v.5" stroke="$hex" stroke-width="1.8" stroke-linecap="round"/>
</svg>''', size);
  }

  static Widget sparkle(Color c, [double size = 18]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M12 3l1.8 5.2L19 10l-5.2 1.8L12 17l-1.8-5.2L5 10l5.2-1.8L12 3z" fill="$hex"/>
</svg>''', size);
  }

  static Widget apple(Color c, [double size = 18]) {
    final hex = _hex(c);
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 18" fill="$hex">
  <path d="M11.5.5c.1 1-.3 2-.9 2.7-.6.7-1.6 1.3-2.5 1.2-.1-1 .4-2 1-2.6.6-.7 1.6-1.2 2.4-1.3zM14 13c-.4.9-.6 1.3-1.1 2-.7 1.1-1.7 2.5-3 2.5-1.1 0-1.4-.7-2.9-.7s-1.9.7-3 .7c-1.3 0-2.2-1.3-3-2.4C-1 12.6.1 8 2.6 7.1c.9-.3 1.7 0 2.5.3.6.2 1.2.5 1.9.5.7 0 1.3-.3 1.9-.5.9-.3 1.7-.7 2.7-.4 1.1.3 2 1.1 2.6 2.2-1.7.9-2.3 3.1-1.2 4.8z"/>
</svg>''', size);
  }

  static Widget google([double size = 18]) {
    return _svg('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 18 18">
  <path d="M17.6 9.2c0-.6-.1-1.2-.2-1.7H9v3.3h4.8c-.2 1.1-.8 2-1.8 2.6v2.2h2.9c1.7-1.6 2.7-3.9 2.7-6.4z" fill="#4285F4"/>
  <path d="M9 18c2.4 0 4.5-.8 6-2.2l-2.9-2.2c-.8.5-1.8.9-3.1.9-2.4 0-4.4-1.6-5.1-3.8H.9v2.3C2.4 15.9 5.4 18 9 18z" fill="#34A853"/>
  <path d="M3.9 10.7c-.2-.5-.3-1.1-.3-1.7s.1-1.2.3-1.7V5H.9C.3 6.2 0 7.5 0 9s.3 2.8.9 4l3-2.3z" fill="#FBBC05"/>
  <path d="M9 3.6c1.3 0 2.5.5 3.5 1.4l2.6-2.6C13.5.9 11.4 0 9 0 5.4 0 2.4 2.1.9 5l3 2.3C4.6 5.1 6.6 3.6 9 3.6z" fill="#EA4335"/>
</svg>''', size);
  }
}
