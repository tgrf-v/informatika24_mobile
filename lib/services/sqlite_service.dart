import '../models/barang.dart';
import 'storage_service.dart';

/// Implementasi penyimpanan berbasis SQLite Native
/// (Tugas Kontributor: tambahkan package sqflite dan path)
class SqliteService implements StorageService {
  final List<Barang> _dummy = [];

  @override
  Future<List<Barang>> muatBarang() async {
    return List.unmodifiable(_dummy);
  }

  @override
  Future<void> simpanBarang(List<Barang> daftar) async {
    _dummy
      ..clear()
      ..addAll(daftar);
  }

  @override
  Future<void> tambahBarang(Barang barang) async {
    _dummy.add(barang);
  }

  @override
  Future<void> ubahBarang(Barang barang) async {
    final index = _dummy.indexWhere((b) => b.kode == barang.kode);
    if (index >= 0) {
      _dummy[index] = barang;
    }
  }

  @override
  Future<void> hapusBarang(String kode) async {
    _dummy.removeWhere((b) => b.kode == kode);
  }
}
