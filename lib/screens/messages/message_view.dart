import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/user.dart';
import 'package:kfupm_community_app/screens/messages/widgets/message_body.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';


class MessageView extends StatefulWidget {
  const MessageView(
      {Key? key,
      required this.sellerUid,
      required this.sellerUsername,
      this.sellerProfileUrl})
      : super(key: key);

  final sellerUid, sellerUsername, sellerProfileUrl;

  @override
  State<MessageView> createState() =>
      _MessageViewState(sellerUid, sellerUsername, sellerProfileUrl);
}

class _MessageViewState extends State<MessageView> {
  CollectionReference chats = FirebaseFirestore.instance.collection('chats');
  final sellerUid, sellerUsername, sellerProfileUrl;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  String? chatDocId;

  _MessageViewState(this.sellerUid, this.sellerUsername, this.sellerProfileUrl);

  @override
  void initState() {
    super.initState();
    refreshUser();
    initChatId();
  }

  void refreshUser() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  void initChatId() async {
    QuerySnapshot querySnapshot = await chats
        .where('users', isEqualTo: {currentUserId: null, sellerUid: null})
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        chatDocId = querySnapshot.docs.single.id;
      });
    } else {
      final currentUser = Provider.of<UserProvider>(context, listen: false);
      DocumentReference value = await chats.add({
        'buyerUsername': currentUser.user!.username,
        'buyerProfileUrl': currentUser.user!.profilePhotoUrl,
        'sellerUsername': sellerUsername,
        'sellerProfileUrl': sellerProfileUrl,
        'users': {
          currentUserId: null,
          sellerUid: null,
        }
      });

      setState(() {
        chatDocId = value.id;
        print(chatDocId);
        print('I am hereeeeee');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkThemeColor.withOpacity(0.65),
      body: MessageBody(
        chatDocId: chatDocId,
      ),
      appBar: AppBar(
        backgroundColor: darkThemeColor,
        foregroundColor: Colors.lightGreenAccent,
        title: Row(children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.sellerProfileUrl),
          ),
          SizedBox(width: 10),
          Column(
            children: [
              Text(
                widget.sellerUsername,
                style: TextStyle(fontSize: 20),
              )
            ],
          )
        ]),
      ),
    );
  }
}
