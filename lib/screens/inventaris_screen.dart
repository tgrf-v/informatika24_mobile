import 'package:flutter/material.dart';

import '../models/barang.dart';
import '../widgets/barang_card.dart';

class InventarisScreen extends StatefulWidget {
  const InventarisScreen({super.key});

  @override
  State<InventarisScreen> createState() => _InventarisScreenState();
}

class _InventarisScreenState extends State<InventarisScreen> {
  // TAHAP 1: Inisialisasi data sementara di RAM.
  final List<Barang> _barang = [
    const Barang(kode: 'BRG001', nama: 'Mouse',           jenis: 'Periferal',   stok: 5,  harga: 150000),
    const Barang(kode: 'BRG002', nama: 'Keyboard',        jenis: 'Periferal',   stok: 3,  harga: 350000),
    const Barang(kode: 'BRG003', nama: 'Monitor',         jenis: 'Layar',       stok: 8,  harga: 1500000),
    const Barang(kode: 'BRG004', nama: 'CPU',             jenis: 'Komputer',    stok: 6,  harga: 4500000),
    const Barang(kode: 'BRG005', nama: 'Laptop',          jenis: 'Komputer',    stok: 4,  harga: 8000000),
    const Barang(kode: 'BRG006', nama: 'Proyektor',       jenis: 'Presentasi',  stok: 2,  harga: 5000000),
    const Barang(kode: 'BRG007', nama: 'Kabel HDMI',      jenis: 'Kabel',       stok: 10, harga: 50000),
    const Barang(kode: 'BRG008', nama: 'Switch Hub',      jenis: 'Jaringan',    stok: 3,  harga: 300000),
    const Barang(kode: 'BRG009', nama: 'UPS',             jenis: 'Daya',        stok: 5,  harga: 1200000),
    const Barang(kode: 'BRG010', nama: 'Headset',         jenis: 'Periferal',   stok: 7,  harga: 250000),
    const Barang(kode: 'BRG011', nama: 'Webcam',          jenis: 'Periferal',   stok: 4,  harga: 400000),
    const Barang(kode: 'BRG012', nama: 'Kabel LAN',       jenis: 'Kabel',       stok: 15, harga: 25000),
    const Barang(kode: 'BRG013', nama: 'Router Wi-Fi',    jenis: 'Jaringan',    stok: 3,  harga: 450000),
    const Barang(kode: 'BRG014', nama: 'Flashdisk 64GB',  jenis: 'Periferal',   stok: 10, harga: 85000),
    const Barang(kode: 'BRG015', nama: 'Printer Laser',   jenis: 'Periferal',   stok: 2,  harga: 2500000),
    const Barang(kode: 'BRG016', nama: 'Kabel Power',     jenis: 'Kabel',       stok: 8,  harga: 35000),
    const Barang(kode: 'BRG017', nama: 'Speaker',         jenis: 'Periferal',   stok: 4,  harga: 175000),
  ];

  @override
  Widget build(BuildContext context) {
    final int totalUnit = _barang.fold(0, (sum, item) => sum + item.stok);

    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris Laboratorium')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_barang.length} jenis barang',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  'Total: $totalUnit unit',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: _barang.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 48),
                        SizedBox(height: 8),
                        Text('Belum ada data barang'),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: _barang.length,
                    itemBuilder: (context, i) => BarangCard(barang: _barang[i]),
                  ),
          ),
        ],
      ),
    );
  }
}
