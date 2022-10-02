import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kfupm_community_app/utils/constants.dart';

class AddFeedsPostProvider extends ChangeNotifier {
  String defaultPhotoUrl;
  Uint8List? feedsPostFile;
  bool isLoading;

  AddFeedsPostProvider({
    this.defaultPhotoUrl = defaultFeedsPostPic,
    this.feedsPostFile,
    this.isLoading = false,
  });

  void setPhotoUrl(String url) {
    defaultPhotoUrl = url;
    notifyListeners();
  }

  void setPhotoFile(Uint8List? file) {
    feedsPostFile = file;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
