import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mds_project/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Groupe de tests pour les scénarios de bout en bout
  group('end-to-end test', () {
    // Test de connexion réussie
    testWidgets('Login bon', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Recherche des champs de texte par leur clé
      final textFieldFinder1 = find.byKey(const Key('email'));
      final textFieldFinder = find.byKey(const Key('mdp'));

      // Saisie des informations de connexion
      await tester.enterText(textFieldFinder1, 'teo@garbarinoo.co');
      await tester.enterText(textFieldFinder, '1234567');

      // Recherche et appui sur le bouton de connexion
      final buttonFinder = find.byKey(const Key('login'));
      await tester.tap(buttonFinder);
    });

    // Test de connexion échouée
    testWidgets('Login faux', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Recherche des champs de texte par leur clé
      final textFieldFinder1 = find.byKey(const Key('email'));
      final textFieldFinder = find.byKey(const Key('mdp'));

      // Saisie des informations de connexion incorrectes
      await tester.enterText(textFieldFinder1, 'teo@garbarinoo.co');
      await tester.enterText(textFieldFinder, '12367');

      // Recherche et appui sur le bouton de connexion
      final buttonFinder = find.byKey(const Key('login'));
      await tester.tap(buttonFinder);
    });
  });
}
