import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:informatika24_mobile/screens/inventaris_screen.dart';

void main() {
  testWidgets('hapus barang perlu konfirmasi', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: InventarisScreen()),
    );

    await tester.tap(find.byTooltip('Hapus').first);
    await tester.pumpAndSettle();
    expect(find.text('Apakah Anda yakin ingin menghapus "Mouse"?'), findsOneWidget);

    await tester.tap(find.text('Batal'));
    await tester.pumpAndSettle();

    expect(find.text('12 jenis barang'), findsOneWidget);
    expect(find.text('Mouse'), findsOneWidget);
  });

  testWidgets('menghapus barang dan menampilkan SnackBar setelah konfirmasi',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: InventarisScreen()),
    );

    await tester.tap(find.byTooltip('Hapus').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Hapus').last);
    await tester.pumpAndSettle();

    expect(find.text('11 jenis barang'), findsOneWidget);
    expect(find.text('Mouse berhasil dihapus'), findsOneWidget);
    expect(find.text('Mouse'), findsNothing);
  });
}
