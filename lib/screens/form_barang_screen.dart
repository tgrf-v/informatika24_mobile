import 'package:flutter/material.dart';

import '../models/barang.dart';

class FormBarangScreen extends StatefulWidget {
  final Barang? barang;

  const FormBarangScreen({super.key, this.barang});

  @override
  State<FormBarangScreen> createState() => _FormBarangScreenState();
}

class _FormBarangScreenState extends State<FormBarangScreen> {
  static const List<String> _daftarJenis = [
    'Periferal',
    'Layar',
    'Komputer',
    'Presentasi',
    'Kabel',
    'Jaringan',
    'Daya',
    'Lainnya',
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _kodeController;
  late final TextEditingController _namaController;
  late final TextEditingController _stokController;
  late final TextEditingController _hargaController;
  late String _jenis;

  bool get _isEditMode => widget.barang != null;

  @override
  void initState() {
    super.initState();
    _kodeController = TextEditingController(text: widget.barang?.kode ?? '');
    _namaController = TextEditingController(text: widget.barang?.nama ?? '');
    _stokController = TextEditingController(
      text: widget.barang?.stok.toString() ?? '',
    );
    _hargaController = TextEditingController(
      text: widget.barang != null && widget.barang!.harga > 0
          ? widget.barang!.harga.toString()
          : '',
    );

    final jenisAwal = widget.barang?.jenis;
    if (jenisAwal != null && _daftarJenis.contains(jenisAwal)) {
      _jenis = jenisAwal;
    } else {
      _jenis = _daftarJenis.first;
    }
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _stokController.dispose();
    _hargaController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final barangHasil = Barang(
      kode: _kodeController.text.trim(),
      nama: _namaController.text.trim(),
      jenis: _jenis,
      stok: int.parse(_stokController.text.trim()),
      harga: int.tryParse(_hargaController.text.trim()) ?? 0,
    );

    Navigator.pop(context, barangHasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Ubah Barang' : 'Tambah Barang'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _kodeController,
              readOnly: _isEditMode,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: 'Kode Barang',
                prefixIcon: const Icon(Icons.qr_code_2),
                helperText: _isEditMode ? 'Kode barang tidak dapat diubah' : null,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Kode barang wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama Barang',
                prefixIcon: const Icon(Icons.label_outline),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama barang wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _jenis,
              decoration: InputDecoration(
                labelText: 'Jenis Barang',
                prefixIcon: const Icon(Icons.category_outlined),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              items: _daftarJenis
                  .map(
                    (jenis) => DropdownMenuItem(
                      value: jenis,
                      child: Text(jenis),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _jenis = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stokController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Stok',
                prefixIcon: const Icon(Icons.numbers),
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              validator: (value) {
                final jumlah = int.tryParse(value?.trim() ?? '');
                if (jumlah == null) {
                  return 'Stok harus berupa angka bulat';
                }
                if (jumlah < 0) {
                  return 'Stok tidak boleh negatif';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _hargaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga (Opsional)',
                prefixIcon: const Icon(Icons.payments_outlined),
                hintText: '0',
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return null;
                final harga = int.tryParse(value.trim());
                if (harga == null) {
                  return 'Harga harus berupa angka';
                }
                if (harga < 0) {
                  return 'Harga tidak boleh negatif';
                }
                return null;
              },
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _simpan,
              icon: const Icon(Icons.save_outlined),
              label: Text(_isEditMode ? 'Simpan Perubahan' : 'Tambah Barang'),
              style: FilledButton.styleFrom(
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
  }
}
