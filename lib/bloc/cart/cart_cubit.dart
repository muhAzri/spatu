import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spatu/models/cart.dart';

import '../../models/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState(carts: [])) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString('cart');
    if (cartJson != null) {
      final cartList = json.decode(cartJson) as List;
      final carts = cartList.map((e) => CartModel.fromJson(e)).toList();
      emit(state.copyWith(carts: carts));
    }
  }

  Future<void> _saveCart(List<CartModel> carts) async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = json.encode(carts);
    await prefs.setString('cart', cartJson);
  }

  void addProduct(ProductModel product) {
    if (isExist(product)) {
      int index =
          state.carts.indexWhere((element) => element.product.id == product.id);
      List<CartModel> updatedCarts = List.from(state.carts);
      updatedCarts[index] = updatedCarts[index]
          .copyWith(quantity: updatedCarts[index].quantity + 1);
      emit(state.copyWith(carts: updatedCarts));
    } else {
      List<CartModel> updatedCarts = List.from(state.carts);
      updatedCarts.add(
        CartModel(
          id: state.carts.length,
          product: product,
          quantity: 1,
        ),
      );
      emit(state.copyWith(carts: updatedCarts));
    }
    _saveCart(state.carts);
  }

  void removeCart(int id) {
    List<CartModel> updatedCarts = List.from(state.carts);
    updatedCarts.removeAt(id);
    emit(state.copyWith(carts: updatedCarts));
    _saveCart(state.carts);
  }

  void removeAllCart() {
    emit(state.copyWith(carts: []));
    _saveCart(state.carts);
  }

  void addQuantity(int id) {
    List<CartModel> updatedCarts = List.from(state.carts);
    updatedCarts[id] =
        updatedCarts[id].copyWith(quantity: updatedCarts[id].quantity + 1);
    emit(state.copyWith(carts: updatedCarts));
    _saveCart(state.carts);
  }

  void reduceQuantity(int id) {
    List<CartModel> updatedCarts = List.from(state.carts);
    updatedCarts[id] =
        updatedCarts[id].copyWith(quantity: updatedCarts[id].quantity - 1);
    if (updatedCarts[id].quantity == 0) {
      updatedCarts.removeAt(id);
    }
    emit(state.copyWith(carts: updatedCarts));
    _saveCart(state.carts);
  }

  int totalItems() {
    int total = 0;
    for (var item in state.carts) {
      total += item.quantity;
    }
    return total;
  }

  double totalPrice() {
    double total = 0;
    for (var item in state.carts) {
      total += (item.quantity * item.product.price);
    }
    return total;
  }

  bool isExist(ProductModel product) {
    if (state.carts.indexWhere((cart) => cart.product.id == product.id) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
