import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfupm_community_app/firebase_backend/firestore_methods.dart';
import 'package:kfupm_community_app/providers/sell_product_post.dart';
import 'package:kfupm_community_app/providers/user.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:kfupm_community_app/utils/helper.dart';
import 'package:kfupm_community_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class SellProductPage extends StatelessWidget {
  SellProductPage({Key? key}) : super(key: key);

  final List<String> categories = [
    'Furniture',
    'Clothing',
    'Electronics',
    'Perfumes',
    'Decoration',
    'Books',
    'Sports',
    'Others',
  ];

  final List<String> itemConditionCategories = [
    '0',
    '1',
    '2',
    '3',
    '4',
  ];

  final TextEditingController descriptionTextController =
      TextEditingController();

  final TextEditingController priceTextController = TextEditingController();
  final TextEditingController titleTextController = TextEditingController();

  void actionSelectImage(BuildContext context,
      SellProductPostProvider sellProductPostProvider) async {
    Uint8List? imageFile = await Utils.pickImage(ImageSource.gallery);
    if (imageFile != null) {
      sellProductPostProvider.setPhotoFile(imageFile);
    }
  }

  void actionPost(
      BuildContext context,
      String title,
      String price,
      String description,
      String category,
      SellProductPostProvider sellProductPostProvider) async {
    sellProductPostProvider.setIsLoading(true);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();

    bool isPosted = await FirestoreMethods().uploadProductPostToFirestore(
      context,
      title,
      description,
      price,
      sellProductPostProvider.productPostFile!,
      category,
      userProvider.user!.username,
      userProvider.user!.profilePhotoUrl,
    );
    print(userProvider.user!.profilePhotoUrl);
    if (isPosted) {
      sellProductPostProvider.setIsLoading(false);
      Utils.showSnackbar(context, 'Posted!', SnackBarType.Success);
      Navigator.pop(context);
    } else {
      sellProductPostProvider.setIsLoading(false);
      Utils.showSnackbar(context, 'Could not be posted!', SnackBarType.Error);
      Navigator.pop(context);
    }
  }

  void predictPrice(BuildContext context) {
    Utils.showSnackbar(
        context, 'Suggested Price: SAR 32.65', SnackBarType.Info);
  }

  @override
  Widget build(BuildContext context) {
    final SellProductPostProvider sellProductPostProvider =
        Provider.of<SellProductPostProvider>(context, listen: false);

    Future.delayed(Duration.zero).then((value) {
      sellProductPostProvider.setDropdownValue('');
      sellProductPostProvider.setIsLoading(false);
      sellProductPostProvider.setPhotoFile(null);
      sellProductPostProvider.setItemConditionDropdownValue('');
    });

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
            'Sell Product',
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
                height: 5,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Consumer<SellProductPostProvider>(
                  builder: (context, provider, child) => Container(
                    width: 300.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: Color(0xff7c94b6),
                      image: DecorationImage(
                        image: (provider.productPostFile != null)
                            ? MemoryImage(provider.productPostFile!)
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
                  actionSelectImage(
                    context,
                    sellProductPostProvider,
                  );
                },
                child: Text(
                  'Select an image',
                  style: TextStyle(color: primaryColor),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 350,
                height: 50,
                child: TextField(
                  controller: titleTextController,
                  keyboardType: TextInputType.text,
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
                    hintText: 'Enter title',
                    hintStyle: secondaryTextStyle,
                    labelText: 'Title',
                    labelStyle: secondaryTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFf7c600),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  style: secondaryTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                child: TextField(
                  controller: priceTextController,
                  keyboardType: TextInputType.number,
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
                    hintText: 'Enter price (SAR)',
                    hintStyle: secondaryTextStyle,
                    labelText: 'Price (SAR)',
                    labelStyle: secondaryTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFf7c600),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  style: secondaryTextStyle,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                child: Consumer<SellProductPostProvider>(
                  builder: (context, provider, child) =>
                      DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: darkThemeColor,
                      hint: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Select Category',
                          style: secondaryTextStyle,
                        ),
                      ),
                      value: provider.dropdownValue.isNotEmpty
                          ? provider.dropdownValue
                          : null,
                      items: categories
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  item,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? item) {
                        print(item);
                        if (item != null) {
                          sellProductPostProvider.setDropdownValue(item);
                        }
                      },
                      style: secondaryTextStyle,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFf7c600),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                height: 50,
                child: Consumer<SellProductPostProvider>(
                  builder: (context, provider, child) =>
                      DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: darkThemeColor,
                      hint: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Select Item Condition',
                          style: secondaryTextStyle,
                        ),
                      ),
                      value: provider.itemConditionDropdown.isNotEmpty
                          ? provider.itemConditionDropdown
                          : null,
                      items: itemConditionCategories
                          .map(
                            (item) => DropdownMenuItem(
                              value: item,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  item,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? item) {
                        print(item);
                        if (item != null) {
                          sellProductPostProvider
                              .setItemConditionDropdownValue(item);
                        }
                      },
                      style: secondaryTextStyle,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFf7c600),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 350,
                child: TextField(
                  controller: descriptionTextController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 8,
                  maxLength: 500,
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
                    labelText: 'Description',
                    labelStyle: secondaryTextStyle,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFFf7c600),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  style: secondaryTextStyle,
                ),
              ),
              Consumer<SellProductPostProvider>(
                builder: ((context, provider, child) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            actionPost(
                              context,
                              titleTextController.text,
                              priceTextController.text,
                              descriptionTextController.text,
                              sellProductPostProvider.dropdownValue,
                              sellProductPostProvider,
                            );
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
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            predictPrice(context);
                          },
                          icon: Icon(
                            Icons.info_outlined,
                            color: Color(0xFF2BF3A0),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
