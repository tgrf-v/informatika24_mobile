import '../models/barang.dart';

/// Antarmuka abstrak untuk layer penyimpanan data inventaris
abstract class StorageService {
  Future<List<Barang>> muatBarang();
  Future<void> simpanBarang(List<Barang> daftar);
  Future<void> tambahBarang(Barang barang);
  Future<void> ubahBarang(Barang barang);
  Future<void> hapusBarang(String kode);
}
