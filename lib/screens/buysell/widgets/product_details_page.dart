import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/screens/messages/message_view.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';

import '../../../utils/text_styles.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({Key? key, required this.data}) : super(key: key);

  final data;

  void navigateToSellerMsgScreen(BuildContext context, String sellerUid,
      String sellerUsername, String sellerProfileUrl) {
    if (data['uid'] != FirebaseAuth.instance.currentUser!.uid) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => MessageView(
            sellerUid: sellerUid,
            sellerUsername: sellerUsername,
            sellerProfileUrl: sellerProfileUrl,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
            'Details',
            style: TextStyle(
              color: Color(0xFFC9ECF8),
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: screenSize.width * 0.95,
                height: screenSize.height * 0.36,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data['postUrl']),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenSize.width * 0.95,
                height: screenSize.height * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 3.0,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF191a19).withOpacity(0.4),
                      spreadRadius: 0.1,
                      blurRadius: 2,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: 150,
                      height: 5,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    // Title of the product.
                    Text(
                      data['title'],
                      style: TextStyle(
                        color: Color(0xFFC9ECF8),
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow
                          .ellipsis, // we can do this after we get snap variable -> snap.product.length > 10 ? TextOverflow.ellipsis : TextOverflow.visible
                    ),
                    SizedBox(
                      height: 5.0,
                    ),

                    // Seller's username.
                    Text(
                      data['username'],
                      style: TextStyle(
                        color: Color(0xFFC9ECF8),
                        fontSize: 15.0,
                        fontStyle: FontStyle.italic,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),

                    // Description of the product.
                    Container(
                      width: screenSize.width * 0.80,
                      height: screenSize.height * 0.28,
                      child: SingleChildScrollView(
                        child: Text(
                          data['description'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    // Price of the product and message button.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'SAR ${data['price']}',
                          style: secondaryTextStyle,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          onPressed: () {
                            navigateToSellerMsgScreen(
                              context,
                              data['uid'],
                              data['username'],
                              data['userProfileUrl'],
                            );
                          },
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Msg Seller',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
