import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spatu/models/form_model/edit_profile_form_model.dart';

import '../models/user.dart';

class UserService {
  final CollectionReference _userRefference =
      FirebaseFirestore.instance.collection('users');

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot snapshot = await _userRefference.doc(id).get();

      return UserModel(
        id: id,
        username: snapshot['username'],
        email: snapshot['email'],
        name: snapshot['name'],
        imageUrl: snapshot['image_url'],
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateUser(EditProfileFormModel formModel) async {
    try {
      _userRefference.doc(formModel.id).update({
        'username': formModel.username,
        'name': formModel.name,
        'email': formModel.email,
      });

      return await getUserById(formModel.id);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> updateProfilePicture(String userId, XFile imageFile) async {
    try {
      String fileName = (imageFile.path);
      Reference firebaseStorageRef =
          _storage.ref().child('user_images/$userId/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(File(imageFile.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await _userRefference.doc(userId).update({'image_url': imageUrl});

      return await getUserById(userId);
    } catch (e) {
      rethrow;
    }
  }
}
