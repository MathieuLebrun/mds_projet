import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mds_project/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('end-to-end test', () {
    testWidgets('Test popUp', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      final bottomNavigationBarFinder = find.byType(BottomNavigationBar);

      // Cliquez sur le troisième élément (indice 2)
      await tester.tap(find.byIcon(Icons.settings).last);

      // Attendez que la transition se termine
      await tester.pumpAndSettle();
    });
  });
}
