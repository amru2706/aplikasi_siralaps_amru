class Kenzo {
  final String id;
  final String nama;
  final String description;
  final String imageUrl;
  bool isFavorite;

  // Constructor with named parameters
  Kenzo({
    required this.id,
    required this.nama,
    required this.description,
    required this.imageUrl,
    this.isFavorite = false,
  });

  // Factory constructor to create an instance from JSON
  factory Kenzo.fromJson(Map<String, dynamic> json) {
    return Kenzo(
      id: json['id'] ?? '',
      nama: json['nama'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'description': description,
      'image_url': imageUrl,
      'isFavorite': isFavorite,
    };
  }
}
