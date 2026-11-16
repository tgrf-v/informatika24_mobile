import 'package:flutter/material.dart';

class KonfirmasiHapusDialog extends StatelessWidget {
  final String namaBarang;

  const KonfirmasiHapusDialog({
    super.key,
    required this.namaBarang,
  });

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Hapus Barang?'),
        content: Text('Apakah Anda yakin ingin menghapus "$namaBarang"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Hapus',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      );
}
