import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/user.dart';
import 'package:kfupm_community_app/screens/messages/message_view.dart';
import 'package:provider/provider.dart';

import 'messages_card.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  void initState() {
    super.initState();
    refreshUser(context);
  }

  void refreshUser(BuildContext context) async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('users[${FirebaseAuth.instance.currentUser!.uid}]',
                  isEqualTo: null)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Nothing to show!'),
              );
            } else if (snapshot.hasData) {
              return Consumer<UserProvider>(
                builder: (context, provider, child) => Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data!.docs[index];

                      var receiverUid;
                      data['users'].forEach((uid, value) {
                        if (uid != FirebaseAuth.instance.currentUser!.uid) {
                          receiverUid = uid;
                        }
                      });

                      //refreshUser(context);

                      var currentUsername = provider.user!.username;
                      String displayUsername;
                      String displayProfileUrl;

                      if (currentUsername == data['buyerUsername']) {
                        displayUsername = data['sellerUsername'];
                        displayProfileUrl = data['sellerProfileUrl'];
                      } else {
                        displayUsername = data['buyerUsername'];
                        displayProfileUrl = data['buyerProfileUrl'];
                      }

                      return MessagesCard(
                        sellerUsername: displayUsername,
                        sellerProfileUrl: displayProfileUrl,
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageView(
                              sellerUid: receiverUid,
                              sellerUsername: displayUsername,
                              sellerProfileUrl: displayProfileUrl,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            return Center(
              child: Text('Empty!'),
            );
          },
        ),
      ],
    );
  }
}
