import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:kfupm_community_app/firebase_backend/storage_methods.dart';
import 'package:kfupm_community_app/models/feeds_post_model.dart';
import 'package:kfupm_community_app/models/sell_product_post_model.dart';
import 'package:kfupm_community_app/models/user_model.dart';
import 'package:kfupm_community_app/utils/helper.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void uploadUserToFirestore(UserCredential userCredential, String username,
      String email, String password, String profilePhotoUrl) async {
    UserModel user = UserModel(
      username: username,
      email: email,
      password: password,
      profilePhotoUrl: profilePhotoUrl,
    );

    await firebaseFirestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set(user.toJson());
  }

  Future<bool> uploadFeedsPostToFirestore(
      String description,
      Uint8List postFile,
      String username,
      String userProfileUrl,
      BuildContext context) async {
    bool isPosted = false;
    try {
      String postId = Uuid().v1();
      String postUrl = await StorageMethods()
          .uploadFeedsPostToStorage('feedsPost', postId, postFile);

      FeedsPostModel postModel = FeedsPostModel(
        postId: postId,
        description: description,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        uid: firebaseAuth.currentUser!.uid,
        username: username,
        userProfileUrl: userProfileUrl,
      );

      await firebaseFirestore
          .collection('feedsposts')
          .doc(postId)
          .set(postModel.toJson());

      isPosted = true;
    } on FirebaseException catch (err) {
      Utils.showSnackbar(context, err.toString(), SnackBarType.Error);
    } on Exception catch (err) {
      print(err.toString());
      Utils.showSnackbar(
          context,
          'Something went wrong in uploading user to firestore!',
          SnackBarType.Error);
    } finally {
      return isPosted;
    }
  }

  Future<bool> uploadCommentToFirestore(String comment, String username,
      String userProfileUrl, String postId, BuildContext context) async {
    bool isPosted = false;
    try {
      if (comment.isNotEmpty) {}
      String commentId = Uuid().v1();

      await firebaseFirestore
          .collection('feedsposts')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({
        'userProfilePic': userProfileUrl,
        'username': username,
        'uid': firebaseAuth.currentUser!.uid,
        'commentContent': comment,
        'commentId': commentId,
        'datePublished': DateTime.now(),
      });

      isPosted = true;
    } on FirebaseException catch (err) {
      Utils.showSnackbar(context, err.toString(), SnackBarType.Error);
    } on Exception catch (err) {
      print(err.toString());
      Utils.showSnackbar(
          context,
          'Something went wrong in uploading comment to firestore!',
          SnackBarType.Error);
    } finally {
      return isPosted;
    }
  }

  Future<bool> uploadProductPostToFirestore(
    BuildContext context,
    String title,
    String description,
    String price,
    Uint8List productPostFile,
    String category,
    String username,
    String userProfileUrl,
  ) async {
    bool isPosted = false;
    try {
      String postId = Uuid().v1();
      String postUrl = await StorageMethods()
          .uploadProductPostToStorage('productPosts', postId, productPostFile);

      SellProductPostModel postModel = SellProductPostModel(
        postId: postId,
        title: title,
        description: description,
        price: price,
        category: category,
        datePublished: DateTime.now(),
        postUrl: postUrl,
        uid: firebaseAuth.currentUser!.uid,
        username: username,
        userProfileUrl: userProfileUrl,
      );

      await firebaseFirestore
          .collection('productposts')
          .doc(postId)
          .set(postModel.toJson());

      isPosted = true;
    } on FirebaseException catch (err) {
      Utils.showSnackbar(context, err.toString(), SnackBarType.Error);
    } on Exception catch (err) {
      print(err.toString());
      Utils.showSnackbar(
          context,
          'Something went wrong in uploading product post to firestore!',
          SnackBarType.Error);
    } finally {
      return isPosted;
    }
  }
}
