import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String description;
  final List<dynamic> colors;
  final List<dynamic> size;
  final Map<String, dynamic> images;
  final num price;
  final num rating;
  final num soldCount;

  const ProductModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.colors,
    required this.size,
    required this.images,
    required this.price,
    required this.rating,
    required this.soldCount,
  });

  factory ProductModel.fromJson(String id, Map<String, dynamic> json) {
    return ProductModel(
      id: id,
      brand: json['brand'],
      name: json['name'],
      description: json['description'],
      colors: json['color'],
      size: json['size'],
      images: json['images'],
      price: json['price'],
      rating: json['rating'],
      soldCount: json['sold_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'name': name,
      'description': description,
      'color': colors,
      'size': size,
      'images': images,
      'price': price,
      'rating': rating,
      'sold_count': soldCount,
    };
  }

  @override
  List<Object?> get props =>
      [id, brand, description, colors, size, images, price, rating, soldCount];
}
