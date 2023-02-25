import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spatu/models/product.dart';
import 'package:spatu/services/product_service.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());

        final products = await ProductService().fetchProduct();

        emit(ProductSuccess(products));
      } catch (e) {
        emit(ProductFailed(e.toString()));
      }
    });

    on<SearchProductEvent>((event, emit) async {
      try {
        emit(ProductLoading());

        final products =
            await ProductService().searchProducts(query: event.query);

        emit(ProductSearchSuccess(products));
      } catch (e) {
        emit(ProductFailed(e.toString()));
      }
    });
  }
}
