import 'package:flutter/material.dart';
import '../models/barang.dart';
import '../widgets/ringkasan_stok_widget.dart';

/// Halaman statistik dan ringkasan kondisi inventaris
class StatistikScreen extends StatelessWidget {
  final List<Barang> daftarBarang;

  const StatistikScreen({
    super.key,
    required this.daftarBarang,
  });

  @override
  Widget build(BuildContext context) {
    final totalJenis = daftarBarang.length;
    final totalItem = daftarBarang.fold<int>(0, (acc, item) => acc + item.stok);
    final totalKritis = daftarBarang.where((item) => item.stok <= 2).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik Inventaris'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          RingkasanStokWidget(
            totalJenis: totalJenis,
            totalItem: totalItem,
            totalKritis: totalKritis,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Daftar Barang Kritis (Stok <= 2):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          if (totalKritis == 0)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Semua stok barang berada pada level aman.'),
            )
          else
            ...daftarBarang.where((b) => b.stok <= 2).map(
                  (b) => ListTile(
                    leading: const Icon(Icons.warning, color: Colors.red),
                    title: Text(b.nama),
                    subtitle: Text(b.kode),
                    trailing: Text(
                      'Sisa: ${b.stok}',
                      style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
