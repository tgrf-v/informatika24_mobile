import 'package:flutter/material.dart';

enum FilterStok { semua, kritis, tersedia }

/// Reusable widget filter status stok
class FilterStokChips extends StatelessWidget {
  final FilterStok terpilih;
  final ValueChanged<FilterStok> onSelected;

  const FilterStokChips({
    super.key,
    required this.terpilih,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ChoiceChip(
            label: const Text('Semua'),
            selected: terpilih == FilterStok.semua,
            onSelected: (_) => onSelected(FilterStok.semua),
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Stok Kritis (<= 2)'),
            selected: terpilih == FilterStok.kritis,
            onSelected: (_) => onSelected(FilterStok.kritis),
          ),
          const SizedBox(width: 8),
          ChoiceChip(
            label: const Text('Tersedia (> 2)'),
            selected: terpilih == FilterStok.tersedia,
            onSelected: (_) => onSelected(FilterStok.tersedia),
          ),
        ],
      ),
    );
  }
}
