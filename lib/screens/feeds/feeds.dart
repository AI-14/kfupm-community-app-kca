import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/add_feeds_post.dart';
import 'package:kfupm_community_app/screens/feeds/widgets/add_feed_post_page.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

import 'widgets/feeds_card.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  void navigateToAddFeedsPostPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddFeedsPostPage()),
    ).then((value) {
      Provider.of<AddFeedsPostProvider>(context, listen: false)
          .setPhotoFile(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkThemeColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: darkThemeColor,
        automaticallyImplyLeading: false,
        backgroundColor: darkThemeColor,
        title: Text(
          'Feeds',
          style: TextStyle(
            color: Color(0xFFC9ECF8),
            fontSize: 25,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('feedsposts')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return FeedsCard(
                  data: snapshot.data!.docs[index],
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddFeedsPostPage(context);
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: primaryColor,
      ),
    );
  }
}
