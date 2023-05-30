import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mds_project/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Login bon', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      final textFieldFinder1 = find.byKey(Key('email'));
      final textFieldFinder = find.byKey(Key('mdp'));
      await tester.enterText(textFieldFinder1, 'teo@garbarinoo.co');
      await tester.enterText(textFieldFinder, '1234567');
      final buttonFinder = find.byKey(Key('login'));
      await tester.tap(buttonFinder);
    });

    testWidgets('Login faux', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      final textFieldFinder1 = find.byKey(Key('email'));
      final textFieldFinder = find.byKey(Key('mdp'));
      await tester.enterText(textFieldFinder1, 'teo@garbarinoo.co');
      await tester.enterText(textFieldFinder, '12367');
      final buttonFinder = find.byKey(Key('login'));
      await tester.tap(buttonFinder);
    });
  });
}
