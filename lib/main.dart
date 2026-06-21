import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'theme/theme_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeController(),
      child: const ContractAiApp(),
    ),
  );
}
