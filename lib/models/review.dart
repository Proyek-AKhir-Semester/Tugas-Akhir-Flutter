class Buku {
  final int id;
  final String judul;
  final String penulis;

  Buku({required this.id, required this.judul, required this.penulis});

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'] as int,
      judul: json['judul'] as String,
      penulis: json['penulis'] as String,
    );
  }
}
