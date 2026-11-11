import 'package:flutter/material.dart';

/// Reusable widget tampilan saat data inventaris kosong
class EmptyStateWidget extends StatelessWidget {
  final String pesan;
  final VoidCallback onAksi;

  const EmptyStateWidget({
    super.key,
    required this.pesan,
    required this.onAksi,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 72,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              pesan,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onAksi,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Data Baru'),
            ),
          ],
        ),
      ),
    );
  }
}
