import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/signup_screen_fields.dart';
import '../../../utils/text_styles.dart';
import '../../login/login.dart';
import '../../signup/signup.dart';

class FooterArea extends StatelessWidget {
  final Size screenSize;
  const FooterArea({Key? key, required this.screenSize}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void navigateToSignupScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    ).then((value) {
      Provider.of<SignupScreenFieldsProvider>(context, listen: false)
          .setPhotoFile(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'KFUPM COMMUNITY APP',
          style: TextStyle(
            color: Color(0xFFf7f8f9),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: screenSize.width * 0.5,
          height: screenSize.height * 0.05,
          child: ElevatedButton(
            onPressed: () => navigateToLoginScreen(context),
            child: Text(
              'LOGIN',
              style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF2BF3A0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenSize.width * 0.5,
          height: screenSize.height * 0.05,
          child: ElevatedButton(
            onPressed: () => navigateToSignupScreen(context),
            child: Text(
              'SIGNUP',
              style: TextStyle(
                color: Color(0xFF000000),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFC9ECF8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Welcome to the community!',
          style: secondaryTextStyle,
        ),
      ],
    );
  }
}
