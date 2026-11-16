import 'package:flutter_test/flutter_test.dart';
import 'package:informatika24_mobile/main.dart';

void main() {
  testWidgets('InventarisApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const InventarisApp());
    expect(find.text('Inventaris Laboratorium'), findsOneWidget);
    expect(find.text('12 jenis barang'), findsOneWidget);
    expect(find.text('Total: 72 unit'), findsOneWidget);
    expect(find.text('Mouse'), findsOneWidget);
    expect(find.text('BRG001 • Periferal • Stok: 5'), findsOneWidget);
  });
}
