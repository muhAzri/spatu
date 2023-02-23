import 'package:equatable/equatable.dart';

class SignInFormModel extends Equatable {
  final String email;
  final String password;

  const SignInFormModel({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
