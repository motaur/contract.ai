import 'package:flutter/material.dart';

import '../models/recent.dart';
import '../theme/tokens.dart';
import 'app_icons.dart';
import 'severity.dart';

class RecentRow extends StatelessWidget {
  final Recent r;
  final VoidCallback onTap;
  const RecentRow({super.key, required this.r, required this.onTap});

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: t.hair),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: t.accentSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: AppIcons.doc(t.accent, 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          r.when,
                          style: TextStyle(fontSize: 12, color: t.muted),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: t.muted,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        if (r.red > 0) ...[
                          const SevDot(kind: SevKind.red, size: 7),
                          const SizedBox(width: 4),
                          Text('${r.red}', style: TextStyle(fontSize: 12, color: t.muted)),
                          const SizedBox(width: 6),
                        ],
                        if (r.amber > 0) ...[
                          const SevDot(kind: SevKind.amber, size: 7),
                          const SizedBox(width: 4),
                          Text('${r.amber}', style: TextStyle(fontSize: 12, color: t.muted)),
                          const SizedBox(width: 6),
                        ],
                        if (r.blue > 0) ...[
                          const SevDot(kind: SevKind.blue, size: 7),
                          const SizedBox(width: 4),
                          Text('${r.blue}', style: TextStyle(fontSize: 12, color: t.muted)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              AppIcons.chevR(t.muted, 16),
            ],
          ),
        ),
      ),
    );
  }
}
