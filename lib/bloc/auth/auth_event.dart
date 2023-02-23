part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUp extends AuthEvent {
  final SignUpFormModel data;

  const AuthSignUp(this.data);

  @override
  List<Object> get props => [data];
}

class AuthSignIn extends AuthEvent {
  final SignInFormModel data;

  const AuthSignIn(this.data);

  @override
  List<Object> get props => [data];
}


class AuthSignOut extends AuthEvent {}

class GetCurrentUser extends AuthEvent {
  final String id;

  const GetCurrentUser(this.id);

  @override
  List<Object> get props => [id];
}
