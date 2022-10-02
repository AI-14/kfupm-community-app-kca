import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../providers/signup_screen_fields.dart';
import '../../../utils/color_constants.dart';
import '../../../utils/helper.dart';

class UploadPhotoArea extends StatelessWidget {
  final Size screenSize;
  const UploadPhotoArea({Key? key, required this.screenSize}) : super(key: key);

  void actionAddPhoto(SignupScreenFieldsProvider signupScreenFieldsProvider,
      BuildContext context) async {
    Uint8List? imageFile = await Utils.pickImage(ImageSource.gallery);
    if (imageFile != null) {
      signupScreenFieldsProvider.setPhotoFile(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final SignupScreenFieldsProvider signupScreenFields =
        Provider.of<SignupScreenFieldsProvider>(context, listen: false);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Consumer<SignupScreenFieldsProvider>(
            builder: (context, provider, child) => Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    color: Color(0xff7c94b6),
                    image: DecorationImage(
                      image: (provider.photoFile != null)
                          ? MemoryImage(provider.photoFile!) as ImageProvider
                          : NetworkImage(provider.photoUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 1.0,
                    ),
                  ),
                )),
        Positioned(
          left: screenSize.width * 0.14,
          bottom: -screenSize.height * 0.02,
          child: IconButton(
            onPressed: () {
              actionAddPhoto(signupScreenFields, context);
            },
            icon: Icon(
              Icons.add_a_photo_rounded,
              color: primaryIconColor,
            ),
          ),
        ),
      ],
    );
  }
}
