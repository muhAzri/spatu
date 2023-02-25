import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductService {
  String capitalize(String s) {
    if (s.isEmpty) {
      return s;
    }
    return s.substring(0, 1).toUpperCase() + s.substring(1);
  }

  final CollectionReference _productReference =
      FirebaseFirestore.instance.collection('products');

  Future<List<ProductModel>> fetchProduct() async {
    try {
      QuerySnapshot snapshot = await _productReference.get();

      List<ProductModel> products = snapshot.docs
          .map(
            (product) => ProductModel.fromJson(
              product.id,
              product.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> searchProducts({required String query}) async {
    try {
      QuerySnapshot snapshot = await _productReference
          .where('name', isGreaterThanOrEqualTo: capitalize(query))
          .where('name', isLessThanOrEqualTo: '${capitalize(query)}\uf8ff')
          .get();

      List<ProductModel> products = snapshot.docs
          .map((product) => ProductModel.fromJson(
                product.id,
                product.data() as Map<String, dynamic>,
              ))
          .toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }
}
