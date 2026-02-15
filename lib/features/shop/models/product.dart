class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final String vetId;
  final int quantity;
  final List<Map<String, dynamic>> reviews;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.vetId,
    this.quantity = 0,
    this.reviews = const [],
    this.imageUrls = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'vetId': vetId,
      'quantity': quantity,
      'reviews': reviews,
      'imageUrls': imageUrls,
    };
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (num.tryParse(map['price'].toString()) ?? 0.0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      category: map['category'] ?? 'General',
      vetId: map['vetId'] ?? '',
      quantity: (num.tryParse(map['quantity'].toString()) ?? 0).toInt(),
      reviews: List<Map<String, dynamic>>.from(map['reviews'] ?? []),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}
