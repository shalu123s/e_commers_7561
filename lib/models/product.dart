
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final List<String> images; // Additional images for the product
  final double rating;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.images = const [],
    this.rating = 0.0,
    this.stock = 0,
  });

  // Factory constructor to create a Product from a map (e.g., from Firebase)
  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      rating: (map['rating'] ?? 0).toDouble(),
      stock: map['stock'] ?? 0,
    );
  }

  // Method to convert a Product to a map (e.g., for uploading to Firebase)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'images': images,
      'rating': rating,
      'stock': stock,
    };
  }
}
