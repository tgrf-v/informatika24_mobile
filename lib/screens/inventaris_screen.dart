import 'package:flutter/material.dart';

import '../models/barang.dart';
import '../services/pref_service.dart';
import '../widgets/barang_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/top_banner_widget.dart';
import 'form_barang_screen.dart';

enum UrutanBarang {
  namaAsc('Nama (A-Z)'),
  namaDesc('Nama (Z-A)'),
  stokDesc('Stok Terbanyak'),
  stokAsc('Stok Tersedikit');

  final String label;
  const UrutanBarang(this.label);
}

class InventarisScreen extends StatefulWidget {
  final PrefService? prefService;

  const InventarisScreen({super.key, this.prefService});

  @override
  State<InventarisScreen> createState() => _InventarisScreenState();
}

class _InventarisScreenState extends State<InventarisScreen> {
  PrefService? _prefService;
  final TextEditingController _searchController = TextEditingController();
  String _kataKunci = '';
  UrutanBarang? _urutan;

  // Inisialisasi data sementara di RAM
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
  void initState() {
    super.initState();
    try {
      _prefService = widget.prefService ?? PrefService();
      _muatData();
    } catch (_) {
      // Abaikan jika platform channel shared_preferences tidak tersedia (e.g. widget test)
    }
  }

  OverlayEntry? _overlayEntry;

  void _tampilkanNotifikasiAtas({
    required String pesan,
    bool isError = false,
  }) {
    _overlayEntry?.remove();
    _overlayEntry = null;

    final overlay = Overlay.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => TopBannerWidget(
        pesan: pesan,
        isError: isError,
        topPadding: mediaQuery.padding.top + kToolbarHeight,
        backgroundColor: isError ? colorScheme.errorContainer : colorScheme.primaryContainer,
        foregroundColor: isError ? colorScheme.onErrorContainer : colorScheme.onPrimaryContainer,
        onDismissed: () {
          entry.remove();
          if (_overlayEntry == entry) _overlayEntry = null;
        },
      ),
    );

    _overlayEntry = entry;
    overlay.insert(entry);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _muatData() async {
    try {
      final tersimpan = await _prefService?.muatBarang();
      if (tersimpan != null && tersimpan.isNotEmpty && mounted) {
        setState(() {
          _barang
            ..clear()
            ..addAll(tersimpan);
        });
      }
    } catch (_) {}
  }

  Future<void> _simpanKeStorage() async {
    try {
      await _prefService?.simpanBarang(_barang);
    } catch (_) {}
  }

  List<Barang> get _barangTerfilter {
    final kataKunci = _kataKunci.trim().toLowerCase();
    final hasil = kataKunci.isEmpty
        ? List<Barang>.from(_barang)
        : _barang.where((item) {
            return item.nama.toLowerCase().contains(kataKunci) ||
                item.kode.toLowerCase().contains(kataKunci) ||
                item.jenis.toLowerCase().contains(kataKunci);
          }).toList();

    if (_urutan != null) {
      switch (_urutan!) {
        case UrutanBarang.namaAsc:
          hasil.sort(
            (a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()),
          );
        case UrutanBarang.namaDesc:
          hasil.sort(
            (a, b) => b.nama.toLowerCase().compareTo(a.nama.toLowerCase()),
          );
        case UrutanBarang.stokDesc:
          hasil.sort((a, b) => b.stok.compareTo(a.stok));
        case UrutanBarang.stokAsc:
          hasil.sort((a, b) => a.stok.compareTo(b.stok));
      }
    }

    return hasil;
  }

  String _generateKodeBaru() {
    int maxNomor = 0;
    for (final item in _barang) {
      final match = RegExp(r'^BRG(\d+)$', caseSensitive: false).firstMatch(item.kode);
      if (match != null) {
        final nomor = int.tryParse(match.group(1) ?? '0') ?? 0;
        if (nomor > maxNomor) maxNomor = nomor;
      }
    }
    final berikutnya = maxNomor + 1;
    return 'BRG${berikutnya.toString().padLeft(3, '0')}';
  }

  Future<void> _tambahBarang() async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(
        builder: (_) => FormBarangScreen(kodeOtomatis: _generateKodeBaru()),
      ),
    );
    if (!mounted || hasil == null) return;

    final isKodeDuplikat = _barang.any(
      (item) => item.kode.toLowerCase() == hasil.kode.toLowerCase(),
    );
    if (isKodeDuplikat) {
      _tampilkanNotifikasiAtas(
        pesan: 'Kode barang "${hasil.kode}" sudah digunakan!',
        isError: true,
      );
      return;
    }

    setState(() => _barang.add(hasil));
    await _simpanKeStorage();

    if (!mounted) return;
    _tampilkanNotifikasiAtas(pesan: '${hasil.nama} berhasil ditambahkan ✓');
  }

  Future<void> _ubahBarang(Barang barang) async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => FormBarangScreen(barang: barang)),
    );
    if (!mounted || hasil == null) return;

    final index = _barang.indexWhere((item) => item.kode == barang.kode);
    if (index != -1) {
      setState(() => _barang[index] = hasil);
      await _simpanKeStorage();

      if (!mounted) return;
      _tampilkanNotifikasiAtas(pesan: '${hasil.nama} berhasil diperbarui ✓');
    }
  }

  Future<void> _konfirmasiHapus(Barang barang) async {
    final konfirmasi = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Barang?'),
        content: Text('Apakah Anda yakin ingin menghapus "${barang.nama}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (konfirmasi != true || !mounted) return;

    setState(() => _barang.removeWhere((item) => item.kode == barang.kode));
    await _simpanKeStorage();

    if (!mounted) return;
    _tampilkanNotifikasiAtas(
      pesan: '${barang.nama} berhasil dihapus',
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final daftarTampil = _barangTerfilter;
    final int totalUnit = _barang.fold(0, (sum, item) => sum + item.stok);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Laboratorium'),
        actions: [
          PopupMenuButton<UrutanBarang>(
            icon: const Icon(Icons.sort_rounded),
            tooltip: 'Urutkan Barang',
            initialValue: _urutan,
            onSelected: (pilihan) {
              setState(() => _urutan = pilihan);
            },
            itemBuilder: (context) => UrutanBarang.values.map(
              (urutan) => PopupMenuItem<UrutanBarang>(
                value: urutan,
                child: Row(
                  children: [
                    if (_urutan == urutan)
                      Icon(
                        Icons.check,
                        size: 18,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    else
                      const SizedBox(width: 18),
                    const SizedBox(width: 8),
                    Text(urutan.label),
                  ],
                ),
              ),
            ).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) => setState(() => _kataKunci = value),
            onClear: () => setState(() => _kataKunci = ''),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
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
                ? const EmptyStateWidget(
                    judul: 'Belum ada data barang',
                    pesan: 'Tekan tombol Tambah Barang untuk mulai mencatat inventaris.',
                  )
                : daftarTampil.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.search_off_rounded,
                        judul: 'Barang tidak ditemukan',
                        pesan: 'Coba gunakan kata kunci pencarian yang lain.',
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(0, 6, 0, 88),
                        itemCount: daftarTampil.length,
                        itemBuilder: (context, i) => BarangCard(
                          barang: daftarTampil[i],
                          onEdit: () => _ubahBarang(daftarTampil[i]),
                          onDelete: () => _konfirmasiHapus(daftarTampil[i]),
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahBarang,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Barang'),
      ),
    );
  }
}
