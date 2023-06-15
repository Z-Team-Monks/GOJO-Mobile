import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:gojo/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login as a tenant using valid credentials', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final phoneTextField = find.byType(TextFormField).first;
    await tester.enterText(phoneTextField, "0955211643");
    final passwordTextField = find.byType(TextFormField).last;
    await tester.enterText(passwordTextField, "123");
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(0, 0));
    await tester.pumpAndSettle();
    final login = find.byType(ElevatedButton).last;
    await tester.tap(login);
    await tester.pump();
    await tester.pumpAndSettle();
    final text = find.text("Register");
    await tester.pumpAndSettle();
    expect(text, findsNothing);
  });
}
