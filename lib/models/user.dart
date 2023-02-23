import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? name;
  final String username;
  final String email;
  final String? imageUrl;

  const UserModel({
    this.name,
    required this.id,
    required this.username,
    required this.email,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id,name, username, email, imageUrl];
}
