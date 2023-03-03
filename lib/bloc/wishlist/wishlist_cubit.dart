import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spatu/models/product.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(const WishlistState(wishlist: [])) {
    loadWishlist();
  }

  Future<void> loadWishlist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> wishlistIds = prefs.getStringList('wishlist') ?? [];
    final List<ProductModel> wishlist = [];
    for (final id in wishlistIds) {
      final String? jsonStr = prefs.getString('product_$id');
      if (jsonStr != null) {
        final Map<String, dynamic> json =
            jsonDecode(jsonStr) as Map<String, dynamic>;
        final ProductModel product = ProductModel.fromJson(id, json);
        wishlist.add(product);
      }
    }
    emit(WishlistState(wishlist: wishlist));
  }

  Future<void> saveWishlist(List<ProductModel> wishlist) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> wishlistIds =
        wishlist.map((product) => product.id).toList();
    await prefs.setStringList('wishlist', wishlistIds);
    for (final product in wishlist) {
      await prefs.setString(
          'product_${product.id}', jsonEncode(product.toJson()));
    }
  }

  void setWishlist(ProductModel product) {
    final List<ProductModel> wishlist = List.from(state.wishlist);
    if (isWishlist(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
    emit(WishlistState(wishlist: wishlist));
    saveWishlist(wishlist);
  }

  void removeWishlist(ProductModel product) {
    final List<ProductModel> wishlist = List.from(state.wishlist);
    wishlist.remove(product);
    emit(WishlistState(wishlist: wishlist));
    saveWishlist(wishlist);
  }

  bool isWishlist(ProductModel product) {
    final List<ProductModel> wishlist = state.wishlist;
    if (wishlist.contains(product)) {
      return true;
    }
    return false;
  }
}
