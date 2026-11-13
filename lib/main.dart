import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: InventarisPage(),
));

class Barang {
  final String kode;
  final String nama;
  final int stok;
  const Barang({required this.kode, required this.nama, required this.stok});
  Barang copyWith({String? nama, int? stok}) => Barang(
    kode: kode, nama: nama ?? this.nama, stok: stok ?? this.stok,
  );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventaris Laboratorium')),
      body: ListView.builder(
          itemCount: _barang.length,
          itemBuilder: (context, i) {
            final b = _barang[i];
            return Card(child: ListTile(
              title: Text(b.nama),
              subtitle: Text('${b.kode} • Stok: ${b.stok}'),
            ));
          },
        ),
      floatingActionButton: FloatingActionButton(onPressed: _tambah, child: const Icon(Icons.add)),
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
    appBar: AppBar(title: Text(widget.barang == null ? 'Tambah Barang' : 'Ubah Barang')),
    body: Form(
      key: _form,
      child: ListView(padding: const EdgeInsets.all(16), children: [
        TextFormField(
          controller: _kode,
          readOnly: widget.barang != null,
          decoration: const InputDecoration(labelText: 'Kode barang'),
          validator: (v) => (v == null || v.trim().isEmpty) ? 'Kode wajib diisi' : null,
        ),
        TextFormField(
          controller: _nama,
          decoration: const InputDecoration(labelText: 'Nama barang'),
          validator: (v) => (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
        ),
        TextFormField(
          controller: _stok,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Stok'),
          validator: (v) => int.tryParse(v?.trim() ?? '') == null ? 'Stok harus angka bulat' : null,
        ),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: () {
          if (!_form.currentState!.validate()) return;
          Navigator.pop(context, Barang(
            kode: _kode.text.trim(),
            nama: _nama.text.trim(),
            stok: int.parse(_stok.text.trim()),
          ));
        }, child: const Text('Simpan')),
      ]),
    ),
  );
}