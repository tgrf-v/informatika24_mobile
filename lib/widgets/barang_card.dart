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
    final bool isKritis = barang.stok <= 2;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isKritis ? colorScheme.errorContainer : null,
          child: Icon(
            _ikonJenis(barang.jenis),
            color: isKritis ? colorScheme.onErrorContainer : null,
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(barang.nama)),
            if (isKritis)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Stok Kritis',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onErrorContainer,
                  ),
                ),
              ),
          ],
        ),
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
