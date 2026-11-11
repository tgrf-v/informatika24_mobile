import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: InventarisPage()),
);

class Barang {
  final String kode;
  final String nama;
  final int stok;
  const Barang({required this.kode, required this.nama, required this.stok});
  Barang copyWith({String? nama, int? stok}) =>
      Barang(kode: kode, nama: nama ?? this.nama, stok: stok ?? this.stok);
  Map<String, dynamic> toJson() => {'kode': kode, 'nama': nama, 'stok': stok};
  factory Barang.fromJson(Map<String, dynamic> j) => Barang(
    kode: j['kode'] as String,
    nama: j['nama'] as String,
    stok: (j['stok'] as num).toInt(),
  );
}

class InventarisPage extends StatefulWidget {
  const InventarisPage({super.key});
  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  final List<Barang> _barang = [
    const Barang(kode: 'BRG001', nama: 'Mouse', stok: 5),
    const Barang(kode: 'BRG002', nama: 'Keyboard', stok: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris Laboratorium')),
      body: const Center(child: Text('Tahap 0: kerangka aplikasi siap')),
      floatingActionButton: null,
    );
  }
}
