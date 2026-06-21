import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router.dart';
import 'theme/theme_controller.dart';
import 'theme/tokens.dart';

class ContractAiApp extends StatelessWidget {
  const ContractAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeController>();
    final t = controller.tokens;
    return TokensScope(
      tokens: t,
      child: MaterialApp.router(
        title: 'contract.ai',
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        theme: _buildTheme(t, dark: controller.dark),
      ),
    );
  }

  ThemeData _buildTheme(Tokens t, {required bool dark}) {
    final brightness = dark ? Brightness.dark : Brightness.light;
    final base = ThemeData(
      brightness: brightness,
      useMaterial3: true,
      fontFamily: 'Ploni',
      scaffoldBackgroundColor: t.bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: t.accent,
        brightness: brightness,
      ),
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: t.ink,
        displayColor: t.ink,
        fontFamily: 'Ploni',
      ),
    );
  }
}
