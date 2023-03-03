part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  final List<ProductModel> wishlist;

  const WishlistState({required this.wishlist});

  @override
  List<Object?> get props => [wishlist];
}