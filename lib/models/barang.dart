class Barang {
  final String kode;
  final String nama;
  final String jenis;
  final int stok;
  final int harga;

  const Barang({
    required this.kode,
    required this.nama,
    required this.jenis,
    required this.stok,
    this.harga = 0,
  });

  Barang copyWith({
    String? nama,
    String? jenis,
    int? stok,
    int? harga,
  }) =>
      Barang(
        kode: kode,
        nama: nama ?? this.nama,
        jenis: jenis ?? this.jenis,
        stok: stok ?? this.stok,
        harga: harga ?? this.harga,
      );

  Map<String, dynamic> toJson() => {
        'kode': kode,
        'nama': nama,
        'jenis': jenis,
        'stok': stok,
        'harga': harga,
      };

  factory Barang.fromJson(Map<String, dynamic> j) => Barang(
        kode: j['kode'] as String,
        nama: j['nama'] as String,
        jenis: j['jenis'] as String,
        stok: (j['stok'] as num).toInt(),
        harga: (j['harga'] as num?)?.toInt() ?? 0,
      );
}

