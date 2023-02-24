import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductService {
  final CollectionReference _productRefference =
      FirebaseFirestore.instance.collection('products');

  Future<List<ProductModel>> fetchProduct() async {
    try {
      QuerySnapshot snapshot = await _productRefference.get();

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
}
