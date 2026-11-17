class Barang {
  final String kode;
  final String nama;
  final String jenis;
  final int stok;
  final int harga;
  final String deskripsi;

  const Barang({
    required this.kode,
    required this.nama,
    required this.jenis,
    required this.stok,
    this.harga = 0,
    this.deskripsi = '',
  });

  Barang copyWith({
    String? nama,
    String? jenis,
    int? stok,
    int? harga,
    String? deskripsi,
  }) =>
      Barang(
        kode: kode,
        nama: nama ?? this.nama,
        jenis: jenis ?? this.jenis,
        stok: stok ?? this.stok,
        harga: harga ?? this.harga,
        deskripsi: deskripsi ?? this.deskripsi,
      );

  Map<String, dynamic> toJson() => {
        'kode': kode,
        'nama': nama,
        'jenis': jenis,
        'stok': stok,
        'harga': harga,
        'deskripsi': deskripsi,
      };

  factory Barang.fromJson(Map<String, dynamic> j) => Barang(
        kode: j['kode'] as String,
        nama: j['nama'] as String,
        jenis: j['jenis'] as String,
        stok: (j['stok'] as num).toInt(),
        harga: (j['harga'] as num?)?.toInt() ?? 0,
        deskripsi: (j['deskripsi'] as String?) ?? '',
      );
}

