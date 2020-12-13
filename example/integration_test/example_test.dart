import 'package:example/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Example', (WidgetTester tester) async {
    await app.main();
    await tester.pumpAndSettle();

    final title = find.text('firestore_ref example');
    expect(title, findsOneWidget);
  });
}
