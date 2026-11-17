import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:informatika24_mobile/main.dart';

void main() {
  testWidgets('Filter Kategori menampilkan kategori dan menyaring barang', (WidgetTester tester) async {
    await tester.pumpWidget(const InventarisApp());
    await tester.pumpAndSettle();

    // Default filter adalah "Semua"
    expect(find.widgetWithText(ChoiceChip, 'Semua'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Periferal'), findsOneWidget);
    expect(find.widgetWithText(ChoiceChip, 'Layar'), findsOneWidget);

    // Filter "Layar"
    await tester.tap(find.widgetWithText(ChoiceChip, 'Layar'));
    await tester.pumpAndSettle();

    // Hanya barang kategori Layar yang tampil (Monitor)
    expect(find.text('Monitor'), findsOneWidget);
    expect(find.text('Mouse'), findsNothing);
    expect(find.text('Keyboard'), findsNothing);

    // Kembalikan ke filter "Semua"
    await tester.tap(find.widgetWithText(ChoiceChip, 'Semua'));
    await tester.pumpAndSettle();

    expect(find.text('Mouse'), findsOneWidget);
    expect(find.text('Monitor'), findsOneWidget);
  });

  testWidgets('Sorting barang berfungsi sesuai pilihan', (WidgetTester tester) async {
    await tester.pumpWidget(const InventarisApp());
    await tester.pumpAndSettle();

    // Buka dropdown sorting
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    // Pilihan sorting tersedia
    expect(find.text('Nama A–Z').last, findsOneWidget);
    expect(find.text('Nama Z–A').last, findsOneWidget);
    expect(find.text('Stok paling sedikit').last, findsOneWidget);
    expect(find.text('Stok paling banyak').last, findsOneWidget);

    // Pilih Stok paling sedikit
    await tester.tap(find.text('Stok paling sedikit').last);
    await tester.pumpAndSettle();

    // Barang dengan stok sedikit tampil di atas (misal Proyektor stok: 2)
    expect(find.text('Proyektor'), findsOneWidget);
  });

  testWidgets('Filter kategori, sorting, dan pencarian bekerja bersamaan', (WidgetTester tester) async {
    await tester.pumpWidget(const InventarisApp());
    await tester.pumpAndSettle();

    // Filter kategori "Komputer"
    await tester.tap(find.widgetWithText(ChoiceChip, 'Komputer'));
    await tester.pumpAndSettle();

    // Di kategori Komputer ada CPU (stok 6) dan Laptop (stok 4)
    expect(find.text('CPU'), findsOneWidget);
    expect(find.text('Laptop'), findsOneWidget);

    // Urutkan berdasarkan Nama Z–A
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Nama Z–A').last);
    await tester.pumpAndSettle();

    // Cari kata kunci "Lap"
    await tester.enterText(find.byType(TextField), 'Lap');
    await tester.pumpAndSettle();

    expect(find.text('Laptop'), findsOneWidget);
    expect(find.text('CPU'), findsNothing);
  });
}
