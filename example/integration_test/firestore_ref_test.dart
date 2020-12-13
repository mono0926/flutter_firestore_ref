import 'package:example/main.dart' as app;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('API', () {
    setUpAll(() async {
      await Firebase.initializeApp();
      await FirebaseAuth.instance.signInAnonymously();
    });

    test('Firestore', () async {
      final usersRef = FirebaseFirestore.instance.collection('users');
      final querySnap = await usersRef.get();
      expect(querySnap.size, equals(1));
    });
  });

  group('Example', () {
    testWidgets('Example', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();

      final title = find.text('firestore_ref example');
      expect(title, findsOneWidget);
    });
  });
}
