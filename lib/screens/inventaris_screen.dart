import 'package:flutter/material.dart';

import '../models/barang.dart';
import '../services/pref_service.dart';
import '../widgets/barang_card.dart';
import '../widgets/empty_state_widget.dart';
import '../widgets/search_bar_widget.dart';
import 'form_barang_screen.dart';

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
  String _kategoriDipilih = 'Semua';
  String? _urutan;

  static const String _sortNamaAZ = 'Nama A–Z';
  static const String _sortNamaZA = 'Nama Z–A';
  static const String _sortStokSedikit = 'Stok paling sedikit';
  static const String _sortStokBanyak = 'Stok paling banyak';

  static const List<String> _daftarUrutan = [
    _sortNamaAZ,
    _sortNamaZA,
    _sortStokSedikit,
    _sortStokBanyak,
  ];

  static const List<String> _kategoriProject = [
    'Semua',
    'Periferal',
    'Layar',
    'Komputer',
    'Presentasi',
    'Kabel',
    'Jaringan',
    'Daya',
    'Lainnya',
  ];

  List<String> get _daftarKategori {
    final list = List<String>.from(_kategoriProject);
    for (final item in _barang) {
      if (!list.contains(item.jenis)) {
        list.add(item.jenis);
      }
    }
    return list;
  }

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

  @override
  void dispose() {
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
    final hasil = _barang.where((item) {
      final cocokKataKunci = kataKunci.isEmpty ||
          item.nama.toLowerCase().contains(kataKunci) ||
          item.kode.toLowerCase().contains(kataKunci) ||
          item.jenis.toLowerCase().contains(kataKunci);
      final cocokKategori = _kategoriDipilih == 'Semua' ||
          item.jenis.toLowerCase() == _kategoriDipilih.toLowerCase();
      return cocokKataKunci && cocokKategori;
    }).toList();

    if (_urutan != null) {
      switch (_urutan) {
        case _sortNamaAZ:
        case 'Nama A-Z':
          hasil.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
          break;
        case _sortNamaZA:
        case 'Nama Z-A':
          hasil.sort((a, b) => b.nama.toLowerCase().compareTo(a.nama.toLowerCase()));
          break;
        case _sortStokSedikit:
        case 'Stok Tersedikit':
          hasil.sort((a, b) {
            final cmp = a.stok.compareTo(b.stok);
            return cmp != 0 ? cmp : a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
          });
          break;
        case _sortStokBanyak:
        case 'Stok Terbanyak':
          hasil.sort((a, b) {
            final cmp = b.stok.compareTo(a.stok);
            return cmp != 0 ? cmp : a.nama.toLowerCase().compareTo(b.nama.toLowerCase());
          });
          break;
      }
    }

    return hasil;
  }

  Future<void> _tambahBarang() async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => const FormBarangScreen()),
    );
    if (!mounted || hasil == null) return;

    final isKodeDuplikat = _barang.any(
      (item) => item.kode.toLowerCase() == hasil.kode.toLowerCase(),
    );
    if (isKodeDuplikat) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kode barang "${hasil.kode}" sudah digunakan!')),
      );
      return;
    }

    setState(() => _barang.add(hasil));
    await _simpanKeStorage();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${hasil.nama} berhasil ditambahkan')),
    );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${hasil.nama} berhasil diperbarui')),
      );
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${barang.nama} berhasil dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daftarTampil = _barangTerfilter;
    final int totalUnit = _barang.fold(0, (sum, item) => sum + item.stok);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventaris Laboratorium'),
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onChanged: (value) => setState(() => _kataKunci = value),
            onClear: () => setState(() => _kataKunci = ''),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: _daftarKategori.map((kategori) {
                final isSelected = _kategoriDipilih == kategori;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(kategori),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _kategoriDipilih = kategori);
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 2),
            child: Row(
              children: [
                const Icon(Icons.sort, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Urutkan:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _urutan,
                      hint: const Text('Pilih Urutan'),
                      isDense: true,
                      items: _daftarUrutan
                          .map(
                            (u) => DropdownMenuItem(
                              value: u,
                              child: Text(u),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() => _urutan = val);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
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
                        padding: const EdgeInsets.symmetric(vertical: 6),
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
