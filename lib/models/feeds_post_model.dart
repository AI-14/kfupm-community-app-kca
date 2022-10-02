import 'package:cloud_firestore/cloud_firestore.dart';

class FeedsPostModel {
  final String postId;
  final String description;
  final datePublished;
  final String postUrl;
  final String uid;
  final String username;
  final String userProfileUrl;
  

  FeedsPostModel({
    required this.postId,
    required this.description,
    required this.datePublished,
    required this.postUrl,
    required this.uid,
    required this.username,
    required this.userProfileUrl,
    
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> postMap = {};

    postMap['postId'] = postId;
    postMap['description'] = description;
    postMap['datePublished'] = datePublished;
    postMap['postUrl'] = postUrl;
    postMap['uid'] = uid;
    postMap['username'] = username;
    postMap['userProfileUrl'] = userProfileUrl;
    
    return postMap;
  }

  static FeedsPostModel fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return FeedsPostModel(
      postId: snapshot['postId'],
      description: snapshot['description'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      userProfileUrl: snapshot['userProfileUrl'],
      
    );
  }
}
