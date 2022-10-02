import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';

class MessageInput extends StatelessWidget {
  MessageInput({
    Key? key,
    required this.chatDocId,
  }) : super(key: key);

  final chatDocId;
  final TextEditingController msgTextController = TextEditingController();

  void sendMessage(String msg) async {
    if (msg == '') return;
    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatDocId)
        .collection('messages')
        .add({
      'createdOn': FieldValue.serverTimestamp(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'msg': msgTextController.text,
    });
    msgTextController.clear();
  }


  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      decoration: BoxDecoration(color: darkThemeColor, boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 20,
            color: Colors.lightGreenAccent.withOpacity(0.9))
      ]),
      child: SafeArea(
          child: Row(
        children: [
          Expanded(
              child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(children: [
              SizedBox(
                width: 7.5,
              ),
              Expanded(
                  child: TextField(
                controller: msgTextController,
                cursorColor: Colors.lightGreenAccent,
                style: TextStyle(color: Colors.lightGreenAccent),
                decoration: InputDecoration(
                    hintText: "Enter message",
                    hintStyle: TextStyle(color: Colors.lightGreenAccent),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 11.5, horizontal: 10)),
              )),
              
              IconButton(
                icon: const Icon(Icons.send),
                color: Colors.lightGreenAccent,
                onPressed: () {
                  print(msgTextController.text);
                  sendMessage(msgTextController.text);
                
                },
              ),
              SizedBox(
                width: 5,
              )
            ]),
          ))
        ],
      )),
    );
  }
}
