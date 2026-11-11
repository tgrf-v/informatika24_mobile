import 'package:flutter/material.dart';

/// Reusable dialog konfirmasi hapus data
class KonfirmasiHapusDialog extends StatelessWidget {
  final String namaItem;
  final String kodeItem;

  const KonfirmasiHapusDialog({
    super.key,
    required this.namaItem,
    required this.kodeItem,
  });

  static Future<bool?> tampilkan(BuildContext context, {required String nama, required String kode}) {
    return showDialog<bool>(
      context: context,
      builder: (_) => KonfirmasiHapusDialog(namaItem: nama, kodeItem: kode),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hapus Data'),
      content: Text('Yakin ingin menghapus "$namaItem" ($kodeItem)?\nTindakan ini tidak dapat dibatalkan.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Hapus', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
