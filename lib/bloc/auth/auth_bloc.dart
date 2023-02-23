import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spatu/models/form_model/sign_up_form_model.dart';
import 'package:spatu/services/auth_service.dart';

import '../../models/form_model/sign_in_form_model.dart';
import '../../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignIn>(
      (event, emit) async {
        try {
          emit(AuthLoading());

          final user = await AuthService().signIn(model: event.data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(
            AuthFailed(
              e.toString(),
            ),
          );
        }
      },
    );

    on<AuthSignUp>(
      (event, emit) async {
        try {
          emit(AuthLoading());

          final user = await AuthService().signUp(model: event.data);

          emit(
            AuthSuccess(user),
          );
        } catch (e) {
          emit(
            AuthFailed(e.toString()),
          );
        }
      },
    );

    on<AuthSignOut>(
      (event, emit) async {
        try {
          await AuthService().signOut();

          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      },
    );

    on<GetCurrentUser>(
      (event, emit) async {
        try {
          UserModel user = await AuthService().getUserById(event.id);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      },
    );
  }
}
