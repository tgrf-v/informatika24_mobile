import 'package:flutter/material.dart';
import '../models/barang.dart';

class BarangCard extends StatelessWidget {
  final Barang barang;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BarangCard({
    super.key,
    required this.barang,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(
          barang.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${barang.kode} • Stok: ${barang.stok}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              tooltip: 'Edit',
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              tooltip: 'Hapus',
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
