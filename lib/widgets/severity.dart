import 'package:flutter/material.dart';

import '../theme/tokens.dart';
import 'app_icons.dart';

class SevChip extends StatelessWidget {
  final SevKind kind;
  final SevStyle style;
  final bool small;

  const SevChip({
    super.key,
    required this.kind,
    this.style = SevStyle.soft,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final c = sevColor(t, kind);
    final isSolid = style == SevStyle.solid;
    final fontSize = small ? 11.0 : 12.0;
    final iconSize = small ? 11.0 : 13.0;
    final pad = small
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 3)
        : const EdgeInsets.symmetric(horizontal: 10, vertical: 5);

    final bg = isSolid ? c.fg : c.bg;
    final fg = isSolid ? Colors.white : c.ink;
    final iconColor = isSolid ? Colors.white : c.fg;

    return Container(
      padding: pad,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sevIcon(kind, iconColor, iconSize),
          const SizedBox(width: 5),
          Text(
            sevLabel(kind),
            style: TextStyle(
              color: fg,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              height: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _sevIcon(SevKind k, Color color, double size) {
  switch (k) {
    case SevKind.red:
      return AppIcons.flag(color, size);
    case SevKind.amber:
      return AppIcons.eye(color, size);
    case SevKind.blue:
      return AppIcons.info(color, size);
  }
}

class SevDot extends StatelessWidget {
  final SevKind kind;
  final double size;
  const SevDot({super.key, required this.kind, this.size = 8});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: sevColor(t, kind).fg,
        shape: BoxShape.circle,
      ),
    );
  }
}
