import 'package:flutter/material.dart';

const Color warnaUtama = Color(0xFF173B70);
const Color warnaAksen = Color(0xFF3478D4);
const Color warnaBackground = Color(0xFFF4F7FB);
const Color warnaTeks = Color(0xFF263449);

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: warnaBackground,
      colorScheme: ColorScheme.fromSeed(
        seedColor: warnaUtama,
        primary: warnaUtama,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: warnaUtama,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    ),
    home: const InventarisPage(),
  ),
);

class Barang {
  final String kode; 
  final String nama;
  final int stok;
  final String kategori;
  const Barang({required this.kode, required this.nama, required this.stok, required this.kategori,});
  Barang copyWith({String? nama, int? stok, String? kategori,}) => Barang(
    kode: kode, nama: nama ?? this.nama, stok: stok ?? this.stok, kategori: kategori ?? this.kategori,
  );
  Map<String, dynamic> toJson() => {'kode': kode, 'nama': nama, 'stok': stok, 'kategori': kategori};
  factory Barang.fromJson(Map<String, dynamic> j) => Barang(
    kode: j['kode'] as String,
    nama: j['nama'] as String,
    stok: (j['stok'] as num).toInt(),
    kategori: j['kategori'] as String,
  );
}
 
class InventarisPage extends StatefulWidget {
  const InventarisPage({super.key});
  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  // Data Barang 
  final List<Barang> _barang = [
    const Barang(kode: 'BRG001', nama: 'Mouse', stok: 5, kategori: 'Komputer'),
    const Barang(kode: 'BRG002', nama: 'Keyboard', stok: 3, kategori: 'Komputer'), 
    const Barang(kode: 'BRG003', nama: 'Router', stok: 2, kategori: 'Jaringan'),
    const Barang(kode: 'BRG004', nama: 'Switch', stok: 4, kategori: 'Jaringan'),
    const Barang(kode: 'BRG005', nama: 'Multimeter', stok: 6, kategori: 'Laboratorium'),
    
  ];

  // Variabel untuk pencarian dan filter 
  String _cari = '';
  String _kategori = 'Semua';

  // Daftar Kategori Barang
  final List<String> kategoriList = [
    'Semua',
    'Komputer',
    'Jaringan',
    'Laboratorium',
  ];

  // fungsi pencarian
    List<Barang> get barangTampil {
    return _barang.where((b) {
      final cocokCari =
          b.nama.toLowerCase().contains(_cari.toLowerCase()) ||
          b.kode.toLowerCase().contains(_cari.toLowerCase());

      final cocokKategori =
          _kategori == 'Semua' || b.kategori == _kategori;

      return cocokCari && cocokKategori;
    }).toList();
  }

  // fungsi tambah barang
  Future<void> _tambah() async {
    final baru = await Navigator.push<Barang>(context,
      MaterialPageRoute(builder: (_) => const FormBarangPage()));
    if (!mounted || baru == null) return;
    if (_barang.any((item) => item.kode.toLowerCase() == baru.kode.toLowerCase())) {
      _pesan('Kode barang sudah digunakan');
      return;
    }
    setState(() => _barang.add(baru));
    
  }

  void _pesan(String pesan) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(pesan)));

  Future<void> _ubah(Barang asal) async {
    final hasil = await Navigator.push<Barang>(context,
      MaterialPageRoute(builder: (_) => FormBarangPage(barang: asal)));
    if (!mounted || hasil == null) return;
    final index = _barang.indexWhere((item) => item.kode == asal.kode);
    if (index < 0) return;
    setState(() => _barang[index] = hasil);
    
  }

  Future<void> _hapus(Barang barang) async {
    final setuju = await showDialog<bool>(context: context, builder: (ctx) =>
      AlertDialog(
        title: const Text('Hapus barang?'),
        content: Text('Hapus ${barang.nama} (${barang.kode})?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Hapus')),
        ],
      ),
    );
    if (!mounted || setuju != true) return;
    setState(() => _barang.removeWhere((item) => item.kode == barang.kode));
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris Laboratorium')),
      body: Column(
  children: [
    // Ringkasan total barang dan kategori
Padding(
  padding: const EdgeInsets.all(12),
  child: Row(
    children: [
      Expanded(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  color: warnaAksen,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  '${_barang.length}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warnaUtama,
                  ),
                ),
                const Text('Total Barang'),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Expanded(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.category_outlined,
                  color: Colors.orange,
                  size: 28,
                ),
                const SizedBox(height: 8),
                Text(
                  '${_barang.map((b) => b.kategori).toSet().length}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: warnaUtama,
                  ),
                ),
                const Text('Total Kategori'),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
),

// Pencarian
    // Pencarian
    Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: (value) {
          setState(() => _cari = value);
        },
        decoration: const InputDecoration(
          hintText: 'Cari nama atau kode barang...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
      ),
    ),

    // Filter kategori
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonFormField<String>(
        value: _kategori,
        decoration: const InputDecoration(
          labelText: 'Filter Kategori',
          border: OutlineInputBorder(),
        ),
        items: kategoriList.map((kategori) {
          return DropdownMenuItem(
            value: kategori,
            child: Text(kategori),
          );
        }).toList(),
        onChanged: (value) {
          setState(() => _kategori = value!);
        },
      ),
    ),

    // Daftar barang
    Expanded(
      child: ListView.builder(
        itemCount: barangTampil.length,
        itemBuilder: (context, i) {
          final b = barangTampil[i];

          return Card(
  color: Colors.white,
  elevation: 1,
  margin: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 5,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(14),
  ),
  
child: ListTile(
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  ),

  // Nama barang
  title: Text(
    b.nama,
    style: const TextStyle(
      color: warnaTeks,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Detail barang
  subtitle: Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Text(
      '${b.kode} • ${b.kategori} • Stok: ${b.stok}',
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 13,
      ),
    ),
  ),

  // Tombol edit dan hapus
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        onPressed: () => _ubah(b),
        icon: const Icon(
          Icons.edit_outlined,
          color: warnaAksen,
        ),
      ),
      IconButton(
        onPressed: () => _hapus(b),
        icon: const Icon(
          Icons.delete_outline,
          color: Colors.redAccent,
        ),
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
      floatingActionButton: FloatingActionButton(
  onPressed: _tambah,
  backgroundColor: warnaUtama,
  foregroundColor: Colors.white,
  child: const Icon(Icons.add),
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
  String _kategori = 'Komputer'; // Default kategori

  @override
  void initState() {
    super.initState();
    _kode = TextEditingController(text: widget.barang?.kode ?? '');
    _nama = TextEditingController(text: widget.barang?.nama ?? '');
    _stok = TextEditingController(text: widget.barang?.stok.toString() ?? '');
    _kategori = widget.barang?.kategori ?? 'Komputer'; // Set kategori dari barang jika ada
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
    appBar: AppBar(title: Text(widget.barang == null ? 'Tambah Barang' : 'Ubah Barang')),
    body: Form(
      key: _form,
      child: ListView(padding: const EdgeInsets.all(16), children: [
        TextFormField(
          controller: _kode,
          readOnly: widget.barang != null,
          decoration: const InputDecoration(labelText: 'Kode barang', border: OutlineInputBorder(),),
          validator: (v) => (v == null || v.trim().isEmpty) ? 'Kode wajib diisi' : null,
        ), 
        const SizedBox(height: 16),
        
        TextFormField( 
          controller: _nama,
          decoration: const InputDecoration(labelText: 'Nama barang'),
          validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
        ),
        // Input Stok
TextFormField(
  controller: _stok,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    labelText: 'Stok',
    border: OutlineInputBorder(),
  ),
),

const SizedBox(height: 16),

// Pilihan Kategori
DropdownButtonFormField<String>(
  value: _kategori,
  decoration: const InputDecoration(
    labelText: 'Kategori Barang',
    border: OutlineInputBorder(),
  ),
  items: ['Komputer', 'Jaringan', 'Laboratorium']
      .map((kategori) {
    return DropdownMenuItem<String>(
      value: kategori,
      child: Text(kategori),
    );
  }).toList(),
  onChanged: (value) {
    if (value != null) {
      setState(() {
        _kategori = value;
      });
    }
  },
),
const SizedBox(height: 16), 
        ElevatedButton(onPressed: () {
          if (!_form.currentState!.validate()) return;
          Navigator.pop(context, Barang(
            kode: _kode.text.trim(),
            nama: _nama.text.trim(),
            stok: int.parse(_stok.text.trim()),
            kategori: _kategori, // Default kategori jika tidak ada
          ));
        }, child: const Text('Simpan')),
      ]),
    ),
  );
}

