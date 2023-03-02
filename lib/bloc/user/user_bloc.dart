import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spatu/models/form_model/edit_profile_form_model.dart';
import 'package:spatu/models/user.dart';

import '../../services/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<GetCurrentUser>(
      (event, emit) async {
        try {
          UserModel user = await UserService().getUserById(event.id);
          emit(UserSuccess(user));
        } catch (e) {
          emit(UserFailed(e.toString()));
        }
      },
    );

    on<EditProfile>((event, emit) async {
      try {
        UserModel user = await UserService().updateUser(event.formModel);
        emit(UserSuccess(user));
      } catch (e) {
        emit(UserFailed(e.toString()));
      }
    });

    on<EditProfilePicture>((event, emit) async {
      try {
        UserModel user = await UserService().updateProfilePicture(event.userId, event.imageFile);
        emit(UserSuccess(user));
      } catch (e) {
        emit(UserFailed(e.toString()));
      }
    });
  }
}
