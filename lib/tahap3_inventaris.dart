import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: _temaInventaris,
    home: InventarisPage(),
  ),
);

const Color _sage = Color(0xFF718B74);
const Color _sageLembut = Color(0xFFEAF0E8);
final ThemeData _temaInventaris = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: _sage,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Color(0xFFF6F8F5),
);

class Barang {
  final String kode;
  final String nama;
  final int stok;

  const Barang({required this.kode, required this.nama, required this.stok});

  Barang copyWith({String? nama, int? stok}) =>
      Barang(kode: kode, nama: nama ?? this.nama, stok: stok ?? this.stok);

  Map<String, dynamic> toJson() => {'kode': kode, 'nama': nama, 'stok': stok};

  factory Barang.fromJson(Map<String, dynamic> j) => Barang(
    kode: j['kode'] as String,
    nama: j['nama'] as String,
    stok: (j['stok'] as num).toInt(),
  );
}

class InventarisPage extends StatefulWidget {
  const InventarisPage({super.key});

  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  final List<Barang> _barang = [
    const Barang(kode: 'BRG001', nama: 'Mouse', stok: 5),
    const Barang(kode: 'BRG002', nama: 'Keyboard', stok: 3),
  ];
  String _kataKunci = '';

  List<Barang> get _barangTerfilter {
    final kataKunci = _kataKunci.trim().toLowerCase();
    if (kataKunci.isEmpty) return _barang;
    return _barang
        .where(
          (barang) =>
              barang.nama.toLowerCase().contains(kataKunci) ||
              barang.kode.toLowerCase().contains(kataKunci),
        )
        .toList();
  }

  Future<void> _bukaForm({Barang? barang}) async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => FormBarangPage(barang: barang)),
    );
    if (!mounted || hasil == null) return;

    if (barang == null) {
      if (_barang.any(
        (item) => item.kode.toLowerCase() == hasil.kode.toLowerCase(),
      )) {
        _pesan('Kode barang sudah digunakan');
        return;
      }
      setState(() => _barang.add(hasil));
      return;
    }

    final index = _barang.indexWhere((item) => item.kode == barang.kode);
    if (index != -1) {
      setState(() => _barang[index] = hasil);
    }
  }

  Future<void> _konfirmasiHapus(Barang barang) async {
    final hapus = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus barang?'),
        content: Text('Barang "${barang.nama}" akan dihapus dari inventaris.'),
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
    if (!mounted || hapus != true) return;
    setState(() => _barang.removeWhere((item) => item.kode == barang.kode));
    _pesan('${barang.nama} berhasil dihapus');
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final daftarBarang = _barangTerfilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventaris Laboratorium',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (value) => setState(() => _kataKunci = value),
              decoration: InputDecoration(
                hintText: 'Cari nama atau kode barang',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _kataKunci.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Hapus pencarian',
                        onPressed: () => setState(() => _kataKunci = ''),
                        icon: const Icon(Icons.close),
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFDCE5DA)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: _sage, width: 1.5),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: [
                const Icon(Icons.inventory_2_outlined, size: 18, color: _sage),
                const SizedBox(width: 8),
                Text(
                  '${daftarBarang.length} barang',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: const Color(0xFF536956),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: daftarBarang.isEmpty
                ? _TampilanKosong(sedangMencari: _kataKunci.trim().isNotEmpty)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 96),
                    itemCount: daftarBarang.length,
                    itemBuilder: (context, index) {
                      final barang = daftarBarang[index];
                      return Card(
                        color: Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: const BorderSide(color: Color(0xFFE5EBE3)),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: _sageLembut,
                            foregroundColor: _sage,
                            child: const Icon(Icons.inventory_2_outlined),
                          ),
                          title: Text(
                            barang.nama,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              '${barang.kode}  •  Stok: ${barang.stok}',
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                tooltip: 'Ubah ${barang.nama}',
                                onPressed: () => _bukaForm(barang: barang),
                                icon: const Icon(Icons.edit_outlined),
                                color: _sage,
                              ),
                              IconButton(
                                tooltip: 'Hapus ${barang.nama}',
                                onPressed: () => _konfirmasiHapus(barang),
                                icon: const Icon(Icons.delete_outline),
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bukaForm,
        backgroundColor: _sage,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah barang'),
      ),
    );
  }
}

class _TampilanKosong extends StatelessWidget {
  final bool sedangMencari;

  const _TampilanKosong({required this.sedangMencari});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: _sageLembut,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: _sage,
              size: 34,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            sedangMencari ? 'Barang tidak ditemukan' : 'Belum ada barang',
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            sedangMencari
                ? 'Coba kata kunci nama atau kode yang lain.'
                : 'Tambahkan barang untuk mulai mengelola inventaris.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: Colors.black54),
          ),
        ],
      ),
    ),
  );
}

class FormBarangPage extends StatefulWidget {
  final Barang? barang;

  const FormBarangPage({super.key, this.barang});

  @override
  State<FormBarangPage> createState() => _FormBarangPageState();
}

class _FormBarangPageState extends State<FormBarangPage> {
  final _form = GlobalKey<FormState>();
  late final TextEditingController _kode;
  late final TextEditingController _nama;
  late final TextEditingController _stok;

  @override
  void initState() {
    super.initState();
    _kode = TextEditingController(text: widget.barang?.kode ?? '');
    _nama = TextEditingController(text: widget.barang?.nama ?? '');
    _stok = TextEditingController(text: widget.barang?.stok.toString() ?? '');
  }

  @override
  void dispose() {
    _kode.dispose();
    _nama.dispose();
    _stok.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.barang == null ? 'Tambah Barang' : 'Ubah Barang'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
    ),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _field(
            controller: _kode,
            label: 'Kode barang',
            icon: Icons.qr_code_2,
            readOnly: widget.barang != null,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Kode wajib diisi'
                : null,
          ),
          const SizedBox(height: 16),
          _field(
            controller: _nama,
            label: 'Nama barang',
            icon: Icons.label_outline,
            validator: (value) => (value == null || value.trim().isEmpty)
                ? 'Nama wajib diisi'
                : null,
          ),
          const SizedBox(height: 16),
          _field(
            controller: _stok,
            label: 'Stok',
            icon: Icons.numbers,
            keyboardType: TextInputType.number,
            validator: (value) {
              final jumlah = int.tryParse(value?.trim() ?? '');
              if (jumlah == null) return 'Stok harus angka bulat';
              if (jumlah < 0) return 'Stok tidak boleh negatif';
              return null;
            },
          ),
          const SizedBox(height: 28),
          FilledButton.icon(
            onPressed: () {
              if (!_form.currentState!.validate()) return;
              Navigator.pop(
                context,
                Barang(
                  kode: _kode.text.trim(),
                  nama: _nama.text.trim(),
                  stok: int.parse(_stok.text.trim()),
                ),
              );
            },
            icon: const Icon(Icons.check),
            label: const Text('Simpan barang'),
            style: FilledButton.styleFrom(
              backgroundColor: _sage,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    bool readOnly = false,
    TextInputType? keyboardType,
  }) => TextFormField(
    controller: controller,
    readOnly: readOnly,
    keyboardType: keyboardType,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFDCE5DA)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _sage, width: 1.5),
      ),
    ),
  );
}
