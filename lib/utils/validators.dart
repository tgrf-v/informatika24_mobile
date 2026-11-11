/// Validasi input form data inventaris
class AppValidators {
  static String? validasiKode(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) {
      return 'Kode barang wajib diisi';
    }
    if (nilai.trim().length < 3) {
      return 'Kode minimal terdiri dari 3 karakter';
    }
    return null;
  }

  static String? validasiNama(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) {
      return 'Nama barang wajib diisi';
    }
    if (nilai.trim().length < 3) {
      return 'Nama minimal terdiri dari 3 karakter';
    }
    return null;
  }

  static String? validasiStok(String? nilai) {
    if (nilai == null || nilai.trim().isEmpty) {
      return 'Jumlah stok wajib diisi';
    }
    final angka = int.tryParse(nilai.trim());
    if (angka == null) {
      return 'Stok harus berupa bilangan bulat';
    }
    if (angka < 0) {
      return 'Stok tidak boleh bernilai negatif';
    }
    return null;
  }
}
