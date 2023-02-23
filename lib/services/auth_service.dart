import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spatu/models/form_model/sign_in_form_model.dart';
import 'package:spatu/models/form_model/sign_up_form_model.dart';

import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final CollectionReference _userRefference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userRefference.doc(user.id).set({
        'email': user.email,
        'username': user.username,
        'name': user.name,
        'image_url': user.imageUrl,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signUp({required SignUpFormModel model}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        username: model.username,
        email: model.email,
      );

      await setUser(user);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signIn({required SignInFormModel model}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: model.email, password: model.password);

      UserModel user =
          await AuthService().getUserById(userCredential.user!.uid);

      return user;
    } catch (e) {
      rethrow;
    }
  }

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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
