import 'package:flutter/material.dart';
import '../models/barang.dart';
import '../widgets/barang_card.dart';
import 'form_barang_screen.dart';

class InventarisScreen extends StatefulWidget {
  const InventarisScreen({super.key});

  @override
  State<InventarisScreen> createState() => _InventarisScreenState();
}

class _InventarisScreenState extends State<InventarisScreen> {
  final List<Barang> _barang = [
    const Barang(kode: 'BRG001', nama: 'Mouse Logitech', stok: 5),
    const Barang(kode: 'BRG002', nama: 'Keyboard Mechanical', stok: 3),
  ];

  void _tampilPesan(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(pesan)),
    );
  }

  Future<void> _tambahBarang() async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => const FormBarangScreen()),
    );

    if (!mounted || hasil == null) return;

    final sudahAda = _barang.any(
      (b) => b.kode.toLowerCase() == hasil.kode.toLowerCase(),
    );

    if (sudahAda) {
      _tampilPesan('Gagal: Kode barang "${hasil.kode}" sudah digunakan.');
      return;
    }

    setState(() => _barang.add(hasil));
    _tampilPesan('Barang "${hasil.nama}" berhasil ditambahkan.');
  }

  Future<void> _ubahBarang(Barang itemLama) async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => FormBarangScreen(barang: itemLama)),
    );

    if (!mounted || hasil == null) return;

    final index = _barang.indexWhere((b) => b.kode == itemLama.kode);
    if (index >= 0) {
      setState(() => _barang[index] = hasil);
      _tampilPesan('Data "${hasil.nama}" berhasil diperbarui.');
    }
  }

  Future<void> _hapusBarang(Barang item) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Apakah Anda yakin ingin menghapus "${item.nama}" (${item.kode})?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (!mounted || konfirmasi != true) return;

    setState(() => _barang.removeWhere((b) => b.kode == item.kode));
    _tampilPesan('Barang "${item.nama}" berhasil dihapus.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Laboratorium'),
        elevation: 1,
      ),
      body: _barang.isEmpty
          ? const Center(
              child: Text(
                'Belum ada data barang.\nTekan tombol + untuk menambahkan.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _barang.length,
              itemBuilder: (context, index) {
                final item = _barang[index];
                return BarangCard(
                  barang: item,
                  onEdit: () => _ubahBarang(item),
                  onDelete: () => _hapusBarang(item),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _tambahBarang,
        tooltip: 'Tambah Barang',
        child: const Icon(Icons.add),
      ),
    );
  }
}
