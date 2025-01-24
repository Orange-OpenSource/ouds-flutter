// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart'; // Importer ton module

void main() {
  test('Vérification des tokens de couleur du thème', () {
    // Créer une instance de ton thème contract
    //final theme = MockTheme();

    // Vérifier que la couleur primaire est bien définie
    //expect(theme.colorTokens.backgroundColorTokens.bgPrimaryLight, isNotNull);
    //expect(theme.colorTokens.backgroundColorTokens.bgPrimaryLight, equals(Color(0xFF34D349))); // Exemple de couleur à tester
  });

  test('Vérification du nom du thème', () {
    // final theme = MockTheme();

    // Vérifier que le nom du thème est correct
    //expect(theme.name, equals("OUDS Flutter"));
  });
}
