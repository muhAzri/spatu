import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spatu/models/brand.dart';

class BrandService {
  final CollectionReference _productRefference =
      FirebaseFirestore.instance.collection('brands');

  Future<List<BrandModel>> fetchBrand() async {
    try {
      QuerySnapshot snapshot = await _productRefference.get();

      List<BrandModel> brand = snapshot.docs
          .map(
            (brand) => BrandModel.fromJson(
              brand.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      return brand;
    } catch (e) {
      rethrow;
    }
  }
}
