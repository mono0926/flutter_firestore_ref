import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async {
    await Firebase.initializeApp();
    await FirebaseAuth.instance.signInAnonymously();
  });

  testWidgets('Firestore', (WidgetTester tester) async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    final querySnap = await usersRef.get();
    expect(querySnap.size, equals(1));
  });
}
