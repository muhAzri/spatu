part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentUser extends UserEvent {
  final String id;

  const GetCurrentUser(this.id);

  @override
  List<Object> get props => [id];
}

class EditProfile extends UserEvent {
  final EditProfileFormModel formModel;

  const EditProfile(this.formModel);

  @override
  List<Object> get props => [formModel];
}

class EditProfilePicture extends UserEvent {
  final String userId;
  final XFile imageFile;

  const EditProfilePicture(this.userId, this.imageFile);

  @override
  List<Object> get props => [userId,imageFile];
}
