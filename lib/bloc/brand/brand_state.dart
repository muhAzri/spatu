part of 'brand_bloc.dart';

abstract class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

class BrandLoading extends BrandState {}

class BrandFailed extends BrandState {
  final String e;

  const BrandFailed(this.e);

  @override
  List<Object> get props => [e];
}

class BrandSuccess extends BrandState {
  final List<BrandModel> brands;

  const BrandSuccess(this.brands);

  @override
  List<Object> get props => [brands];
}
