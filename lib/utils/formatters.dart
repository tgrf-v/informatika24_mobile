/// Helper pemformatan teks dan angka
class AppFormatters {
  static String formatStok(int stok) {
    return '$stok Unit';
  }

  static String ringkasanBarang(String kode, String nama, int stok) {
    return '[$kode] $nama ($stok Unit)';
  }
}
