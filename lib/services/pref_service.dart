import '../models/barang.dart';
import 'storage_service.dart';

/// Implementasi penyimpanan berbasis SharedPreferences
/// (Tugas Kontributor: tambahkan package shared_preferences)
class PrefService implements StorageService {
  final List<Barang> _cache = [];

  @override
  Future<List<Barang>> muatBarang() async {
    return List.unmodifiable(_cache);
  }

  @override
  Future<void> simpanBarang(List<Barang> daftar) async {
    _cache
      ..clear()
      ..addAll(daftar);
  }

  @override
  Future<void> tambahBarang(Barang barang) async {
    _cache.add(barang);
  }

  @override
  Future<void> ubahBarang(Barang barang) async {
    final index = _cache.indexWhere((b) => b.kode == barang.kode);
    if (index >= 0) {
      _cache[index] = barang;
    }
  }

  @override
  Future<void> hapusBarang(String kode) async {
    _cache.removeWhere((b) => b.kode == kode);
  }
}
