import 'package:flutter/material.dart';
import '../models/riwayat_transaksi.dart';

/// Halaman riwayat perubahan dan pergerakan stok barang
class RiwayatScreen extends StatelessWidget {
  final List<RiwayatTransaksi> riwayatList;

  const RiwayatScreen({
    super.key,
    this.riwayatList = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Mutasi Stok'),
      ),
      body: riwayatList.isEmpty
          ? const Center(
              child: Text(
                'Belum ada riwayat pergerakan stok.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: riwayatList.length,
              itemBuilder: (context, index) {
                final r = riwayatList[index];
                final isTambah = r.jumlahPerubahan > 0;
                return ListTile(
                  leading: Icon(
                    isTambah ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isTambah ? Colors.green : Colors.red,
                  ),
                  title: Text('${r.kodeBarang} - ${r.keterangan}'),
                  subtitle: Text(r.tanggal.toLocal().toString().split('.')[0]),
                  trailing: Text(
                    '${isTambah ? '+' : ''}${r.jumlahPerubahan}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isTambah ? Colors.green : Colors.red,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
