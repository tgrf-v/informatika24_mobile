import 'package:flutter_test/flutter_test.dart';
import 'package:informatika24_mobile/main.dart';

void main() {
  testWidgets('InventarisApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const InventarisApp());
    expect(find.text('Inventaris Laboratorium'), findsOneWidget);
  });
}
