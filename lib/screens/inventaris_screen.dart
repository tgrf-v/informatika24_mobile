import 'package:flutter/material.dart';

import '../models/barang.dart';

class InventarisScreen extends StatefulWidget {
  const InventarisScreen({super.key});

  @override
  State<InventarisScreen> createState() => _InventarisScreenState();
}

class _InventarisScreenState extends State<InventarisScreen> {
  // TAHAP 1: Inisialisasi data sementara di RAM.
  final List<Barang> _barang = [
    const Barang(kode: 'BRG001', nama: 'Mouse',           jenis: 'Periferal',   stok: 5),
    const Barang(kode: 'BRG002', nama: 'Keyboard',        jenis: 'Periferal',   stok: 3),
    const Barang(kode: 'BRG003', nama: 'Monitor',         jenis: 'Layar',       stok: 8),
    const Barang(kode: 'BRG004', nama: 'CPU',             jenis: 'Komputer',    stok: 6),
    const Barang(kode: 'BRG005', nama: 'Laptop',          jenis: 'Komputer',    stok: 4),
    const Barang(kode: 'BRG006', nama: 'Proyektor',       jenis: 'Presentasi',  stok: 2),
    const Barang(kode: 'BRG007', nama: 'Kabel HDMI',      jenis: 'Kabel',       stok: 10),
    const Barang(kode: 'BRG008', nama: 'Switch Hub',      jenis: 'Jaringan',    stok: 3),
    const Barang(kode: 'BRG009', nama: 'UPS',             jenis: 'Daya',        stok: 5),
    const Barang(kode: 'BRG010', nama: 'Headset',         jenis: 'Periferal',   stok: 7),
    const Barang(kode: 'BRG011', nama: 'Webcam',          jenis: 'Periferal',   stok: 4),
    const Barang(kode: 'BRG012', nama: 'Kabel LAN',       jenis: 'Kabel',       stok: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris Laboratorium')),
      body: Center(
        child: Text('Data awal: ${_barang.length} barang'),
      ),
    );
  }
}
