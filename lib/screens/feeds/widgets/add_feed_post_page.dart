import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfupm_community_app/firebase_backend/firestore_methods.dart';
import 'package:kfupm_community_app/providers/add_feeds_post.dart';
import 'package:kfupm_community_app/providers/user.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:kfupm_community_app/utils/helper.dart';
import 'package:kfupm_community_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class AddFeedsPostPage extends StatelessWidget {
  AddFeedsPostPage({Key? key}) : super(key: key);

  final TextEditingController descriptionTextController =
      TextEditingController();

  void actionSelectImage(BuildContext context) async {
    Uint8List? imageFile = await Utils.pickImage(ImageSource.gallery);
    if (imageFile != null) {
      Provider.of<AddFeedsPostProvider>(context, listen: false)
          .setPhotoFile(imageFile);
    }
  }

  void actionAddPost(BuildContext context) async {
    final addFeedsProvider =
        Provider.of<AddFeedsPostProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (addFeedsProvider.feedsPostFile == null) {
      Utils.showSnackbar(
          context, 'Please select an image!', SnackBarType.Error);
    } else if (descriptionTextController.text.isEmpty) {
      Utils.showSnackbar(
          context, 'Please write description!', SnackBarType.Warning);
    } else {
      addFeedsProvider.setIsLoading(true);

      await userProvider.refreshUser();
      bool isPosted = await FirestoreMethods().uploadFeedsPostToFirestore(
        descriptionTextController.text,
        addFeedsProvider.feedsPostFile!,
        userProvider.user!.username,
        userProvider.user!.profilePhotoUrl,
        context,
      );
      if (isPosted) {
        addFeedsProvider.setIsLoading(false);
        addFeedsProvider.setPhotoFile(null);

        descriptionTextController.clear();
        Utils.showSnackbar(context, 'Posted!', SnackBarType.Success);
        Navigator.pop(context);
      } else {
        Utils.showSnackbar(context, 'Could not be posted!', SnackBarType.Error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: darkThemeColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: primaryColor,
            ),
          ),
          elevation: 0,
          shadowColor: darkThemeColor,
          backgroundColor: darkThemeColor,
          title: Text(
            'Add Feeds Post',
            style: TextStyle(
              color: Color(0xFFC9ECF8),
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Consumer<AddFeedsPostProvider>(
                  builder: (context, provider, child) => Container(
                    width: 300.0,
                    height: 250.0,
                    decoration: BoxDecoration(
                      color: Color(0xff7c94b6),
                      image: DecorationImage(
                        image: (provider.feedsPostFile != null)
                            ? MemoryImage(provider.feedsPostFile!)
                                as ImageProvider
                            : NetworkImage(provider.defaultPhotoUrl),
                        fit: BoxFit.contain,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  actionSelectImage(context);
                },
                child: Text(
                  'Select an image',
                  style: TextStyle(color: primaryColor),
                ),
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: descriptionTextController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  maxLength: 200,
                  decoration: InputDecoration(
                    
                    counterStyle: secondaryTextStyle,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFf7c600),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    hintText: 'Write your description here...',
                    hintStyle: secondaryTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFC9ECF8)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  style: secondaryTextStyle,
                ),
              ),
              Consumer<AddFeedsPostProvider>(
                builder: ((context, provider, child) => ElevatedButton(
                      onPressed: () {
                        actionAddPost(context);
                      },
                      child: provider.isLoading
                          ? SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'POST',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF2BF3A0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
