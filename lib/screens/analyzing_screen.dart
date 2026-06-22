import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controllers/analysis_controller.dart';
import '../theme/tokens.dart';
import '../widgets/app_icons.dart';

class AnalyzingScreen extends StatefulWidget {
  const AnalyzingScreen({super.key});

  @override
  State<AnalyzingScreen> createState() => _AnalyzingScreenState();
}

class _AnalyzingScreenState extends State<AnalyzingScreen>
    with TickerProviderStateMixin {
  static const _steps = [
    'Extracting text…',
    'Identifying clauses…',
    'Flagging risks…',
  ];

  int _stage = 0;
  bool _navigated = false;
  String? _error;
  late final AnalysisController _ctrl;
  late final AnimationController _scan;
  late final AnimationController _pulse;
  final _timers = <Timer>[];

  @override
  void initState() {
    super.initState();
    _ctrl = context.read<AnalysisController>();
    _ctrl.addListener(_onCtrlChange);

    _scan = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _timers.addAll([
      Timer(const Duration(milliseconds: 1200), () => _setStage(1)),
      Timer(const Duration(milliseconds: 2800), () => _setStage(2)),
    ]);

    // In case analysis already completed before this screen mounted
    WidgetsBinding.instance.addPostFrameCallback((_) => _onCtrlChange());
  }

  void _onCtrlChange() {
    if (_ctrl.status == AnalysisStatus.done && !_navigated) {
      _navigated = true;
      if (mounted) context.go('/results');
    } else if (_ctrl.status == AnalysisStatus.error && _error == null) {
      if (mounted) setState(() => _error = _ctrl.error);
    } else if (_ctrl.status == AnalysisStatus.idle && !_navigated && _error == null) {
      if (mounted) {
        setState(() => _error = 'No analysis started. Please upload a contract first.');
      }
    }
  }

  void _setStage(int s) {
    if (!mounted) return;
    setState(() => _stage = s);
  }

  @override
  void dispose() {
    _ctrl.removeListener(_onCtrlChange);
    for (final t in _timers) {
      t.cancel();
    }
    _scan.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);

    if (_error != null) {
      return _ErrorView(t: t, error: _error!);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0, -0.3),
          radius: 0.8,
          colors: [t.accentSoft, t.bg],
          stops: const [0.0, 0.7],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 60, 28, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(child: _ScanDoc(scan: _scan)),
              const SizedBox(height: 40),
              Text(
                'Reading your contract',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: t.ink,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 260),
                  child: Text(
                    'This usually takes 10–20 seconds. We process everything privately.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: t.muted),
                  ),
                ),
              ),
              const SizedBox(height: 36),
              ...List.generate(_steps.length, (i) => _StepRow(
                    label: _steps[i],
                    done: _stage > i,
                    active: _stage == i,
                    pulse: _pulse,
                  )),
              const Spacer(),
              TextButton(
                onPressed: () {
                  _ctrl.reset();
                  context.go('/home');
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: t.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final Tokens t;
  final String error;
  const _ErrorView({required this.t, required this.error});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: t.bg,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: t.redSoft,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.error_outline, size: 36, color: t.red),
                ),
                const SizedBox(height: 20),
                Text(
                  'Analysis failed',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: t.muted, height: 1.5),
                ),
                const SizedBox(height: 32),
                Material(
                  color: t.accent,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () => context.go('/home'),
                    borderRadius: BorderRadius.circular(12),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                      child: Text(
                        'Go back',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanDoc extends StatelessWidget {
  final AnimationController scan;
  const _ScanDoc({required this.scan});

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    const bars = [0.9, 0.7, 0.85, 0.4, 0.78, 0.6, 0.88, 0.5];
    return SizedBox(
      width: 160,
      height: 200,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: t.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: t.hair),
              boxShadow: [
                BoxShadow(
                  color: t.accent.withValues(alpha: 0.13),
                  blurRadius: 60,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < bars.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: bars[i],
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: i == 2 ? t.accent : t.hair,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          AnimatedBuilder(
            animation: scan,
            builder: (_, __) {
              final y = -22.0 + scan.value * 222.0;
              return Positioned(
                left: 0,
                right: 0,
                top: y,
                height: 22,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        t.accent.withValues(alpha: 0.33),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String label;
  final bool done;
  final bool active;
  final AnimationController pulse;
  const _StepRow({
    required this.label,
    required this.done,
    required this.active,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {
    final t = Tokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: active ? t.accentSoft : t.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: active
                ? t.accent.withValues(alpha: 0.4)
                : t.hair,
          ),
        ),
        child: Row(
          children: [
            AnimatedBuilder(
              animation: pulse,
              builder: (_, __) {
                final pulseScale = active ? (0.85 + 0.15 * pulse.value) : 1.0;
                final pulseOpacity = active ? (0.3 + 0.7 * pulse.value) : 1.0;
                return Opacity(
                  opacity: pulseOpacity,
                  child: Transform.scale(
                    scale: pulseScale,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: done
                            ? t.green
                            : (active ? t.accent : t.hair),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: done ? AppIcons.check(Colors.white, 14) : null,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: done || active ? t.ink : t.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
