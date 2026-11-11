/// Model kategori barang inventaris
class Kategori {
  final String id;
  final String nama;

  const Kategori({
    required this.id,
    required this.nama,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
  };

  factory Kategori.fromJson(Map<String, dynamic> json) {
    return Kategori(
      id: json['id'] as String,
      nama: json['nama'] as String,
    );
  }
}
