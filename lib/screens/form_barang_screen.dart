import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/barang.dart';

class FormBarangScreen extends StatefulWidget {
  final Barang? barang;
  final String? kodeOtomatis;

  const FormBarangScreen({
    super.key,
    this.barang,
    this.kodeOtomatis,
  });

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
  late final TextEditingController _deskripsiController;
  late String _jenis;

  bool get _isEditMode => widget.barang != null;

  static String formatNominal(String value) {
    final clean = value.replaceAll(RegExp(r'\D'), '');
    if (clean.isEmpty) return '';
    final number = int.tryParse(clean) ?? 0;
    final s = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(s[i]);
    }
    return buffer.toString();
  }

  @override
  void initState() {
    super.initState();
    final kodeAwal = widget.barang?.kode ??
        widget.kodeOtomatis ??
        'BRG${(DateTime.now().millisecondsSinceEpoch % 1000).toString().padLeft(3, '0')}';
    _kodeController = TextEditingController(text: kodeAwal);
    _namaController = TextEditingController(text: widget.barang?.nama ?? '');
    _stokController = TextEditingController(
      text: widget.barang?.stok.toString() ?? '',
    );
    _hargaController = TextEditingController(
      text: widget.barang != null && widget.barang!.harga > 0
          ? formatNominal(widget.barang!.harga.toString())
          : '',
    );
    _deskripsiController = TextEditingController(
      text: widget.barang?.deskripsi ?? '',
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
    _deskripsiController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final hargaBersih = _hargaController.text.replaceAll('.', '').trim();

    final barangHasil = Barang(
      kode: _kodeController.text.trim(),
      nama: _namaController.text.trim(),
      jenis: _jenis,
      stok: int.parse(_stokController.text.trim()),
      harga: int.tryParse(hargaBersih) ?? 0,
      deskripsi: _deskripsiController.text.trim(),
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
              readOnly: true,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: _isEditMode ? 'Kode Barang' : 'Kode Barang (Otomatis)',
                prefixIcon: const Icon(Icons.qr_code_2),
                helperText: _isEditMode
                    ? 'Kode barang tidak dapat diubah'
                    : 'Kode barang dibuat otomatis oleh sistem',
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
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                _RibuanInputFormatter(),
              ],
              decoration: InputDecoration(
                labelText: 'Harga (Opsional)',
                prefixIcon: const Icon(Icons.payments_outlined),
                prefixText: 'Rp ',
                prefixStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                hintText: '0',
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return null;
                final clean = value.replaceAll('.', '').trim();
                final harga = int.tryParse(clean);
                if (harga == null) {
                  return 'Harga harus berupa angka';
                }
                if (harga < 0) {
                  return 'Harga tidak boleh negatif';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _deskripsiController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Deskripsi Barang (Opsional)',
                hintText: 'Contoh: Spesifikasi, kondisi, atau catatan barang...',
                prefixIcon: const Icon(Icons.description_outlined),
                alignLabelWithHint: true,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
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

class _RibuanInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final clean = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (clean.isEmpty) return newValue.copyWith(text: '');
    final formatted = _FormBarangScreenState.formatNominal(clean);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
