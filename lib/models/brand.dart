import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final String name;
  final String logoUrl;

  const BrandModel({required this.name, required this.logoUrl});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name'],
      logoUrl: json['logo_url'],
    );
  }

  @override
  List<Object?> get props => [name, logoUrl];
}
