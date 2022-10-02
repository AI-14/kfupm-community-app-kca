import 'package:cloud_firestore/cloud_firestore.dart';

class SellProductPostModel {
  final String postId;
  final String title;
  final String description;
  final String price;
  final String category;
  final datePublished;
  final String postUrl;
  final String uid;
  final String username;
  final String userProfileUrl;

  SellProductPostModel({
    required this.postId,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.datePublished,
    required this.postUrl,
    required this.uid,
    required this.username,
    required this.userProfileUrl,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> postMap = {};

    postMap['postId'] = postId;
    postMap['title'] = title;
    postMap['description'] = description;
    postMap['price'] = price;
    postMap['category'] = category;
    postMap['datePublished'] = datePublished;
    postMap['postUrl'] = postUrl;
    postMap['uid'] = uid;
    postMap['username'] = username;
    postMap['userProfileUrl'] = userProfileUrl;

    return postMap;
  }

  static SellProductPostModel fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> snapshot = snap.data() as Map<String, dynamic>;
    return SellProductPostModel(
      postId: snapshot['postId'],
      title: snapshot['title'],
      description: snapshot['description'],
      price: snapshot['price'],
      category: snapshot['category'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      uid: snapshot['uid'],
      username: snapshot['username'],
      userProfileUrl: snapshot['userProfileUrl'],
    );
  }
}
