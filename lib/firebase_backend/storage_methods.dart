import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> uploadProfilePhotoToStorage(
      String folderName, Uint8List profilePhotoFile) async {
    String userFolderName = firebaseAuth.currentUser!.uid;
    Reference ref = firebaseStorage.ref().child(folderName).child(userFolderName);

    UploadTask uploadTask = ref.putData(profilePhotoFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadFeedsPostToStorage(String folderName, String postId , Uint8List postFile) async {
    String userFolderName = firebaseAuth.currentUser!.uid;
    Reference ref = firebaseStorage.ref().child(folderName).child(userFolderName).child(postId);

    UploadTask uploadTask = ref.putData(postFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> uploadProductPostToStorage(String folderName, String postId , Uint8List postFile) async {
    String userFolderName = firebaseAuth.currentUser!.uid;
    Reference ref = firebaseStorage.ref().child(folderName).child(userFolderName).child(postId);

    UploadTask uploadTask = ref.putData(postFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    return downloadUrl;
  }

}
