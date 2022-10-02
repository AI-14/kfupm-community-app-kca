import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BuySellScreenCategoryProvider extends ChangeNotifier {
  int index;
  Stream<QuerySnapshot<Map<String, dynamic>>>? stream =
      FirebaseFirestore.instance.collection('productposts').snapshots();
  notifyListeners();
  final List<String> categories = [
    'All',
    'Furniture',
    'Clothing',
    'Electronics',
    'Perfumes',
    'Decoration',
    'Books',
    'Sports',
    'Others'
  ];

  BuySellScreenCategoryProvider({this.index = 0});

  void setIndex(int index) {
    this.index = index;
    notifyListeners();
  }

  void setStream() {
    if (index == 0) {
      stream =
          FirebaseFirestore.instance.collection('productposts').snapshots();
      notifyListeners();
    } else {
      stream = FirebaseFirestore.instance
          .collection('productposts')
          .where('category', isEqualTo: categories[index])
          .snapshots();
      notifyListeners();
    }
  }
}
