import 'package:flutter/material.dart';

const List<String> _kategoriBarang = [
  'Perangkat Komputer',
  'Alat Praktikum',
  'Peralatan Jaringan',
  'Perlengkapan Laboratorium',
  'Lainnya',
];

const Color _sageGreen = Color(0xFF718873);
const Color _sageBackground = Color(0xFFF4F7F2);

void main() => runApp(const InventarisApp());

class InventarisApp extends StatelessWidget {
  const InventarisApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Inventaris Laboratorium',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _sageGreen,
        surface: _sageBackground,
      ),
      scaffoldBackgroundColor: _sageBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: _sageBackground,
        foregroundColor: Color(0xFF253329),
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFDCE5DB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _sageGreen, width: 1.5),
        ),
      ),
    ),
    home: const InventarisPage(),
  );
}

class Barang {
  final String kode;
  final String nama;
  final int stok;
  final String kategori;

  const Barang({
    required this.kode,
    required this.nama,
    required this.stok,
    required this.kategori,
  });

  Barang copyWith({String? nama, int? stok, String? kategori}) => Barang(
    kode: kode,
    nama: nama ?? this.nama,
    stok: stok ?? this.stok,
    kategori: kategori ?? this.kategori,
  );

  Map<String, dynamic> toJson() => {
    'kode': kode,
    'nama': nama,
    'stok': stok,
    'kategori': kategori,
  };

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    kode: json['kode'] as String,
    nama: json['nama'] as String,
    stok: (json['stok'] as num).toInt(),
    kategori: json['kategori'] as String? ?? 'Lainnya',
  );
}

class InventarisPage extends StatefulWidget {
  const InventarisPage({super.key});

  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  final List<Barang> _barang = [
    const Barang(
      kode: 'BRG001',
      nama: 'Mouse',
      stok: 5,
      kategori: 'Perangkat Komputer',
    ),
    const Barang(
      kode: 'BRG002',
      nama: 'Keyboard',
      stok: 3,
      kategori: 'Perangkat Komputer',
    ),
  ];
  final TextEditingController _pencarian = TextEditingController();
  String _kataKunci = '';

  @override
  void dispose() {
    _pencarian.dispose();
    super.dispose();
  }

  Future<void> _tambah() async {
    final baru = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => const FormBarangPage()),
    );
    if (!mounted || baru == null) return;
    if (_barang.any(
      (item) => item.kode.toLowerCase() == baru.kode.toLowerCase(),
    )) {
      _pesan('Kode barang sudah digunakan');
      return;
    }
    setState(() => _barang.add(baru));
  }

  Future<void> _ubah(Barang barang) async {
    final hasil = await Navigator.push<Barang>(
      context,
      MaterialPageRoute(builder: (_) => FormBarangPage(barang: barang)),
    );
    if (!mounted || hasil == null) return;
    final index = _barang.indexWhere((item) => item.kode == barang.kode);
    if (index == -1) return;
    setState(() => _barang[index] = hasil);
  }

  Future<void> _hapus(Barang barang) async {
    final konfirmasi = await showDialog<bool>(
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
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (!mounted || konfirmasi != true) return;
    setState(() => _barang.removeWhere((item) => item.kode == barang.kode));
  }

  void _pesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(pesan)));
  }

  @override
  Widget build(BuildContext context) {
    final barangTampil = _barang.where((barang) {
      final query = _kataKunci.toLowerCase();
      return barang.nama.toLowerCase().contains(query) ||
          barang.kode.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventaris Laboratorium',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              controller: _pencarian,
              onChanged: (value) => setState(() => _kataKunci = value.trim()),
              decoration: InputDecoration(
                hintText: 'Cari nama atau kode barang',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _kataKunci.isEmpty
                    ? null
                    : IconButton(
                        tooltip: 'Hapus pencarian',
                        onPressed: () {
                          _pencarian.clear();
                          setState(() => _kataKunci = '');
                        },
                        icon: const Icon(Icons.close),
                      ),
              ),
            ),
          ),
          Expanded(
            child: barangTampil.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _barang.isEmpty
                                ? Icons.inventory_2_outlined
                                : Icons.search_off,
                            size: 48,
                            color: _sageGreen,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _barang.isEmpty
                                ? 'Belum ada barang'
                                : 'Barang tidak ditemukan',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          if (_barang.isEmpty)
                            const Text(
                              'Tekan tombol + untuk menambahkan barang.',
                            ),
                        ],
                      ),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 96),
                    itemCount: barangTampil.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final barang = barangTampil[index];
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.fromLTRB(
                            16,
                            10,
                            8,
                            10,
                          ),
                          title: Text(
                            barang.nama,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kode: ${barang.kode}  •  Stok: ${barang.stok}',
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE7EFE5),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    barang.kategori,
                                    style: const TextStyle(
                                      color: Color(0xFF405A43),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Wrap(
                            spacing: 0,
                            children: [
                              IconButton(
                                tooltip: 'Ubah ${barang.nama}',
                                onPressed: () => _ubah(barang),
                                icon: const Icon(Icons.edit_outlined),
                              ),
                              IconButton(
                                tooltip: 'Hapus ${barang.nama}',
                                onPressed: () => _hapus(barang),
                                icon: const Icon(Icons.delete_outline),
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
        onPressed: _tambah,
        backgroundColor: _sageGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah'),
      ),
    );
  }
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
  String? _kategori;

  @override
  void initState() {
    super.initState();
    _kode = TextEditingController(text: widget.barang?.kode ?? '');
    _nama = TextEditingController(text: widget.barang?.nama ?? '');
    _stok = TextEditingController(text: widget.barang?.stok.toString() ?? '');
    _kategori = widget.barang?.kategori;
  }

  @override
  void dispose() {
    _kode.dispose();
    _nama.dispose();
    _stok.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_form.currentState!.validate()) return;
    final kategori = _kategori;
    if (kategori == null) return;
    Navigator.pop(
      context,
      Barang(
        kode: _kode.text.trim(),
        nama: _nama.text.trim(),
        stok: int.parse(_stok.text.trim()),
        kategori: kategori,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.barang == null ? 'Tambah Barang' : 'Ubah Barang'),
    ),
    body: Form(
      key: _form,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextFormField(
            controller: _kode,
            readOnly: widget.barang != null,
            textCapitalization: TextCapitalization.characters,
            decoration: const InputDecoration(
              labelText: 'Kode Barang',
              prefixIcon: Icon(Icons.qr_code_2),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Kode barang wajib diisi'
                : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _nama,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nama Barang',
              prefixIcon: Icon(Icons.inventory_2_outlined),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Nama barang wajib diisi'
                : null,
          ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            initialValue: _kategori,
            decoration: const InputDecoration(
              labelText: 'Kategori Barang',
              prefixIcon: Icon(Icons.category_outlined),
            ),
            items: _kategoriBarang
                .map(
                  (kategori) =>
                      DropdownMenuItem(value: kategori, child: Text(kategori)),
                )
                .toList(),
            onChanged: (value) => setState(() => _kategori = value),
            validator: (value) =>
                value == null ? 'Kategori barang wajib dipilih' : null,
          ),
          const SizedBox(height: 14),
          TextFormField(
            controller: _stok,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Stok',
              prefixIcon: Icon(Icons.numbers),
            ),
            validator: (value) {
              final jumlah = int.tryParse(value?.trim() ?? '');
              if (jumlah == null) return 'Stok harus berupa angka bulat';
              if (jumlah < 0) return 'Stok tidak boleh negatif';
              return null;
            },
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _simpan,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Simpan Barang'),
            style: FilledButton.styleFrom(
              backgroundColor: _sageGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    ),
  );
}
