import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kfupm_community_app/utils/constants.dart';

class SellProductPostProvider extends ChangeNotifier {
  String defaultPhotoUrl;
  Uint8List? productPostFile;
  bool isLoading;
  String dropdownValue;
  String itemConditionDropdown;

  SellProductPostProvider({
    this.defaultPhotoUrl = defaultFeedsPostPic,
    this.productPostFile,
    this.isLoading = false,
    this.dropdownValue = '',
    this.itemConditionDropdown = '',
  });

  void setPhotoUrl(String url) {
    defaultPhotoUrl = url;
    notifyListeners();
  }

  void setPhotoFile(Uint8List? file) {
    productPostFile = file;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setDropdownValue(String value) {
    dropdownValue = value;
    notifyListeners();
  }

  void setItemConditionDropdownValue(String value) {
    itemConditionDropdown = value;
    notifyListeners();
  }
}
