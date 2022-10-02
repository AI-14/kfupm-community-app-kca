import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_input.dart';

class MessageBody extends StatelessWidget {
  const MessageBody({Key? key, required this.chatDocId}) : super(key: key);

  final chatDocId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(chatDocId)
                  .collection('messages')
                  .orderBy('createdOn', descending: false)
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
                    child: Text('Error in loading msgs!'),
                  );
                }
                print('chatdocid in MessageBody ${chatDocId}');
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) =>
                      Message(data: snapshot.data!.docs[index]),
                );
              },
            ),
          ),
        ),
        MessageInput(
          chatDocId: chatDocId,
        ),
      ],
    );
  }
}

class Message extends StatelessWidget {
  const Message({Key? key, required this.data}) : super(key: key);

  final data;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: data['uid'] == FirebaseAuth.instance.currentUser!.uid
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        MessageBubble(
          data: data,
        ),
      ],
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.data}) : super(key: key);

  final data;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(
          top: 10,
          left: data['uid'] == FirebaseAuth.instance.currentUser!.uid ? 70 : 0,
          right: data['uid'] != FirebaseAuth.instance.currentUser!.uid ? 70 : 0,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.lightGreenAccent.withOpacity(
                data['uid'] == FirebaseAuth.instance.currentUser!.uid
                    ? 1
                    : 0.1),
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          data['msg'],
          style: TextStyle(
              color: data['uid'] == FirebaseAuth.instance.currentUser!.uid
                  ? Colors.black
                  : Colors.white,
              overflow: TextOverflow.visible),
        ),
      ),
    );
  }
}
