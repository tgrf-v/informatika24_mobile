import 'package:flutter/material.dart';

/// Reusable widget kartu ringkasan total stok dan barang
class RingkasanStokWidget extends StatelessWidget {
  final int totalJenis;
  final int totalItem;
  final int totalKritis;

  const RingkasanStokWidget({
    super.key,
    required this.totalJenis,
    required this.totalItem,
    required this.totalKritis,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildItem(context, 'Total Jenis', '$totalJenis', Colors.indigo),
          const SizedBox(width: 8),
          _buildItem(context, 'Total Fisik', '$totalItem', Colors.teal),
          const SizedBox(width: 8),
          _buildItem(context, 'Kritis', '$totalKritis', Colors.red),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withAlpha(80)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
