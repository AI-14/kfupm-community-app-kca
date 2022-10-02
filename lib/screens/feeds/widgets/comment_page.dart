import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/firebase_backend/firestore_methods.dart';
import 'package:kfupm_community_app/providers/user.dart';
import 'package:kfupm_community_app/screens/feeds/widgets/comment_card.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:kfupm_community_app/utils/helper.dart';
import 'package:kfupm_community_app/utils/text_styles.dart';
import 'package:provider/provider.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({Key? key, required this.postId}) : super(key: key);
  final String postId;
  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshUser();
  }

  void refreshUser() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  void actionPostComment(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (commentTextController.text.isEmpty) {
      Utils.showSnackbar(context, 'Empty comment!', SnackBarType.Error);
      return;
    }
    if (commentTextController.text.length > 30) {
      Utils.showSnackbar(
          context, 'Comment length should be <= 30', SnackBarType.Error);

      return;
    }
    await userProvider.refreshUser();
    bool isPosted = await FirestoreMethods().uploadCommentToFirestore(
      commentTextController.text,
      userProvider.user!.username,
      userProvider.user!.profilePhotoUrl,
      widget.postId,
      context,
    );

    if (isPosted) {
      commentTextController.clear();
    } else {
      Utils.showSnackbar(context, 'Could not be posted!', SnackBarType.Error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Comments',
          style: TextStyle(
            color: Color(0xFFC9ECF8),
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('feedsposts')
              .doc(widget.postId)
              .collection('comments')
              .orderBy('datePublished', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error Occured'),
              );
            } else if (!snapshot.hasData) {
              return Center(
                child: Text('Nothing to show!'),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => CommentCard(
                data: snapshot.data!.docs[index],
              ),
            );
          }),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 50,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: EdgeInsets.only(
            left: 16,
            right: 8,
            bottom: 5,
          ),
          child: Consumer<UserProvider>(
            builder: (context, provider, child) => Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(provider.user!.profilePhotoUrl),
                  radius: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextField(
                    controller: commentTextController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      counterStyle: secondaryTextStyle,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFC9ECF8),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'Comment as ${provider.user!.username}',
                      hintStyle: secondaryTextStyle,
                      labelText: 'Comment',
                      labelStyle: secondaryTextStyle,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFC9ECF8),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    style: secondaryTextStyle,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: primaryColor,
                  ),
                  onPressed: () {
                    actionPostComment(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
