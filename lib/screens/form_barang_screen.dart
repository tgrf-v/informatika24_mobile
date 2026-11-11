import 'package:flutter/material.dart';
import '../models/barang.dart';

class FormBarangScreen extends StatefulWidget {
  final Barang? barang;

  const FormBarangScreen({super.key, this.barang});

  @override
  State<FormBarangScreen> createState() => _FormBarangScreenState();
}

class _FormBarangScreenState extends State<FormBarangScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _kodeController;
  late final TextEditingController _namaController;
  late final TextEditingController _stokController;

  @override
  void initState() {
    super.initState();
    _kodeController = TextEditingController(text: widget.barang?.kode ?? '');
    _namaController = TextEditingController(text: widget.barang?.nama ?? '');
    _stokController = TextEditingController(
      text: widget.barang?.stok.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _kodeController.dispose();
    _namaController.dispose();
    _stokController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final hasil = Barang(
      kode: _kodeController.text.trim(),
      nama: _namaController.text.trim(),
      stok: int.parse(_stokController.text.trim()),
    );
    Navigator.pop(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.barang != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Ubah Barang' : 'Tambah Barang'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _kodeController,
              readOnly: isEdit,
              decoration: const InputDecoration(
                labelText: 'Kode Barang',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Kode wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama Barang',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _stokController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah Stok',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                final n = int.tryParse(v?.trim() ?? '');
                if (n == null) return 'Stok harus berupa angka';
                if (n < 0) return 'Stok tidak boleh negatif';
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _simpan,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Simpan Data'),
            ),
          ],
        ),
      ),
    );
  }
}
