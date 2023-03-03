part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartModel> carts;

  const CartState({required this.carts});

  CartState copyWith({List<CartModel>? carts}) {
    return CartState(carts: carts ?? this.carts);
  }

  @override
  List<Object?> get props => [carts];
}