import 'package:flutter/material.dart';
import 'package:kfupm_community_app/screens/messages/widgets/messages_list.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

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
          'Messages',
          style: TextStyle(
            color: Color(0xFFC9ECF8),
            fontSize: 25,
          ),
        ),
      ),
      body: MessagesList(),
    );
  }
}
