import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kfupm_community_app/firebase_backend/firestore_methods.dart';
import 'package:kfupm_community_app/firebase_backend/storage_methods.dart';
import 'package:kfupm_community_app/models/user_model.dart';

import '../utils/helper.dart';

class AuthMethods {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> getCurrentUserDetails() async {
    User currentUser = firebaseAuth.currentUser!;
    DocumentSnapshot snap =
        await firebaseFirestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromSnap(snap);
  }

  Future<bool> signUpUser({
    required String username,
    required String email,
    required String password,
    required Uint8List profilePhotoFile,
    required BuildContext context,
  }) async {
    bool isSignUpSuccessful = false;

    try {
      if (username.isNotEmpty || email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        String profilePhotoUrl = await StorageMethods()
            .uploadProfilePhotoToStorage('profilePhotos', profilePhotoFile);

        FirestoreMethods().uploadUserToFirestore(
            userCredential, username, email, password, profilePhotoUrl);

        // UserModel user = UserModel(
        //     username: username,
        //     email: email,
        //     password: password,
        //     profilePhotoUrl: profilePhotoUrl);

        // await firebaseFirestore
        //     .collection('users')
        //     .doc(userCredential.user!.uid)
        //     .set(user.toJson());

        isSignUpSuccessful = true;
      }
    } on FirebaseAuthException catch (err) {
      Utils.showSnackbar(
        context,
        err.toString(),
        SnackBarType.Error,
      );
    } on Exception catch (err) {
      Utils.showSnackbar(
        context,
        err.toString(),
        SnackBarType.Error,
      );
    }
    return isSignUpSuccessful;
  }

  Future<bool> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    bool isLoginSuccessful = false;
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        isLoginSuccessful = true;
      }
    } on FirebaseAuthException catch (err) {
      Utils.showSnackbar(context, err.toString(), SnackBarType.Error);
    } on Exception catch (err) {
      print(err.toString());
      Utils.showSnackbar(context, 'Something went wrong!', SnackBarType.Error);
    } finally {
      return isLoginSuccessful;
    }
  }

  Future<bool> logoutUser(BuildContext context) async {
    bool isLoggedOut = false;
    try {
      await firebaseAuth.signOut();
      isLoggedOut = true;
    } catch (err) {
      Utils.showSnackbar(context,
          'Error in loggin out! Please try again later.', SnackBarType.Error);
      return isLoggedOut;
    }
    return isLoggedOut;
  }
}
