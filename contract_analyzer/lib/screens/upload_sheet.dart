import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/tokens.dart';
import '../widgets/app_icons.dart';

class _Source {
  final String title;
  final String sub;
  final Widget Function(Color, double) iconBuilder;
  const _Source(this.title, this.sub, this.iconBuilder);
}

/// Shown via showModalBottomSheet from HomeScreen.
class UploadSheet extends StatelessWidget {
  const UploadSheet({super.key});

  static Future<void> show(BuildContext context) {
    final t = Tokens.of(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: t.card,
      barrierColor: Colors.black.withValues(alpha: 0.4),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const UploadSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    final sources = [
      _Source('PDF or document', 'Files app', AppIcons.doc),
      _Source('Photo or scan', 'Camera or library', AppIcons.camera),
      _Source('Paste text', 'From clipboard', AppIcons.text),
      _Source('Cloud storage', 'Drive, Dropbox, iCloud', AppIcons.cloud),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: t.hair,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add a contract',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                    color: t.ink,
                  ),
                ),
                Material(
                  color: t.bg,
                  borderRadius: BorderRadius.circular(999),
                  child: InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      width: 32,
                      height: 32,
                      alignment: Alignment.center,
                      child: AppIcons.close(t.ink2, 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...sources.map((s) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _SourceTile(source: s),
                )),
          ],
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  final _Source source;
  const _SourceTile({required this.source});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Material(
      color: t.bg,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          Future.delayed(const Duration(milliseconds: 120), () {
            if (context.mounted) context.go('/analyzing');
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: t.accentSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: source.iconBuilder(t.accent, 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      source.sub,
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ],
                ),
              ),
              AppIcons.chevR(t.muted, 16),
            ],
          ),
        ),
      ),
    );
  }
}
