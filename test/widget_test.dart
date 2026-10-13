import 'package:flutter_test/flutter_test.dart';
import 'package:hostel_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('hostel_app'), findsOneWidget);
  });
}
