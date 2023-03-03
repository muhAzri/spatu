import 'package:equatable/equatable.dart';
import 'package:spatu/models/product.dart';

class CartModel extends Equatable {
  final int id;
  final int quantity;
  final ProductModel product;

  const CartModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      product: ProductModel.fromJson(json['product']['id'], json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id' : id,
        'quantity': quantity,
        'product': product.toJson(),
      };

  CartModel copyWith({
    int? quantity,
  }) {
    return CartModel(
      id: id,
      product: product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [quantity, product];
}
