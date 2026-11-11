/// Model log perubahan stok barang (masuk/keluar)
class RiwayatTransaksi {
  final String id;
  final String kodeBarang;
  final int jumlahPerubahan;
  final String keterangan;
  final DateTime tanggal;

  const RiwayatTransaksi({
    required this.id,
    required this.kodeBarang,
    required this.jumlahPerubahan,
    required this.keterangan,
    required this.tanggal,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'kodeBarang': kodeBarang,
    'jumlahPerubahan': jumlahPerubahan,
    'keterangan': keterangan,
    'tanggal': tanggal.toIso8601String(),
  };

  factory RiwayatTransaksi.fromJson(Map<String, dynamic> json) {
    return RiwayatTransaksi(
      id: json['id'] as String,
      kodeBarang: json['kodeBarang'] as String,
      jumlahPerubahan: (json['jumlahPerubahan'] as num).toInt(),
      keterangan: json['keterangan'] as String,
      tanggal: DateTime.parse(json['tanggal'] as String),
    );
  }
}
