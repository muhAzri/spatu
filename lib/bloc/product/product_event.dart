part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {}

class SearchProductEvent extends ProductEvent {
  final String query;

  const SearchProductEvent(this.query);
  @override
  List<Object> get props => [query];
}

// class SearchProductByBrandEvent extends ProductEvent {
//   final String brandQuery;

//   const SearchProductByBrandEvent(this.brandQuery);

//   @override
//   List<Object> get props => [brandQuery];

// }
