import 'package:equatable/equatable.dart';

class EditProfileFormModel extends Equatable {
  final String id;
  final String username;
  final String name;
  final String email;

  const EditProfileFormModel({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, username, name, email];
}
