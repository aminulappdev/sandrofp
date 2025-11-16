// app/modules/product/models/product_model.dart
class Product {
  final String id;
  final String name;
  final String descriptions;
  final double price;
  final double discount;
  final String size;
  final String colors;
  final String brands;
  final List<ImageUrl> images;
  final Author? author;

  Product({
    required this.id,
    required this.name,
    required this.descriptions,
    required this.price,
    required this.discount,
    required this.size,
    required this.colors,
    required this.brands,
    required this.images,
    this.author,
  });
}

class ImageUrl {
  final String url;
  ImageUrl({required this.url});
}

class Author {
  final String profile;
  final String name;
  Author({required this.profile, required this.name});
}