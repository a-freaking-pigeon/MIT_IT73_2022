class Item {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String ownerId;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.ownerId,
  });

  factory Item.fromFirestore(String id, Map<String, dynamic> data) {
    return Item(
      id: id,
      title: data['title'],
      description: data['description'],
      price: (data['price'] as num).toDouble(),
      imageUrl: data['imageUrl'],
      ownerId: data['ownerId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'ownerId': ownerId,
    };
  }
}
