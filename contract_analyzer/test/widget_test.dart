import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:contract_analyzer/app.dart';
import 'package:contract_analyzer/theme/theme_controller.dart';

void main() {
  testWidgets('App boots to splash screen', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeController(),
        child: const ContractAiApp(),
      ),
    );
    await tester.pump();
    expect(find.text('Continue with email'), findsOneWidget);
  });

  testWidgets('Dark mode toggle does not crash', (tester) async {
    final controller = ThemeController();
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: controller,
        child: const ContractAiApp(),
      ),
    );
    await tester.pump();
    controller.setDark(true);
    await tester.pump();
    expect(tester.takeException(), isNull);
    controller.setDark(false);
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
