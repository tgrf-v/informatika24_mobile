import 'package:flutter/material.dart';

import '../models/barang.dart';

class BarangCard extends StatelessWidget {
  final Barang barang;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const BarangCard({
    super.key,
    required this.barang,
    this.onEdit,
    this.onDelete,
  });

  static IconData _ikonJenis(String jenis) => switch (jenis.toLowerCase()) {
    'periferal' => Icons.mouse,
    'layar' => Icons.monitor,
    'komputer' => Icons.computer,
    'presentasi' => Icons.videocam,
    'kabel' => Icons.cable,
    'jaringan' => Icons.router,
    'daya' => Icons.battery_charging_full,
    _ => Icons.inventory_2,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_ikonJenis(barang.jenis)),
        ),
        title: Text(barang.nama),
        subtitle: Text('${barang.kode} • ${barang.jenis} • Stok: ${barang.stok}'),
        trailing: (onEdit != null || onDelete != null)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (onEdit != null)
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Ubah',
                      onPressed: onEdit,
                    ),
                  if (onDelete != null)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Hapus',
                      onPressed: onDelete,
                    ),
                ],
              )
            : null,
      ),
    );
  }
}
