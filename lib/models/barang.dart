class Barang {
  final String kode;
  final String nama;
  final int stok;

  const Barang({
    required this.kode,
    required this.nama,
    required this.stok,
  });

  Barang copyWith({
    String? nama,
    int? stok,
  }) {
    return Barang(
      kode: kode,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
    );
  }

  Map<String, dynamic> toJson() => {
    'kode': kode,
    'nama': nama,
    'stok': stok,
  };

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      kode: json['kode'] as String,
      nama: json['nama'] as String,
      stok: (json['stok'] as num).toInt(),
    );
  }
}
