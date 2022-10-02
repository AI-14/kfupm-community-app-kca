import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';

enum SnackBarType {
  Info,
  Success,
  Warning,
  Error,
}

class Utils {
  static void showSnackbar(
      BuildContext context, String msg, SnackBarType snackBarType) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (snackBarType == SnackBarType.Info)
            Icon(
              Icons.info_rounded,
              color: Colors.blue,
            )
          else if (snackBarType == SnackBarType.Success)
            Icon(
              Icons.check_circle_outline_outlined,
              color: primaryColor,
            )
          else if (snackBarType == SnackBarType.Warning)
            Icon(
              Icons.warning_rounded,
              color: warninngColor,
            )
          else if (snackBarType == SnackBarType.Error)
            Icon(
              Icons.error_rounded,
              color: errorColor,
            ),
          Expanded(
            child: Text(
              msg,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      duration: Duration(seconds: 2),
      shape: StadiumBorder(),
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Future<Uint8List?> pickImage(ImageSource imageSource) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: imageSource);

    if (file != null) {
      return await file.readAsBytes();
    }

    return null;
  }
}
