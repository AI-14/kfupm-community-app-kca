import 'package:flutter/material.dart';
import 'package:kfupm_community_app/screens/welcome/widgets/body_image.dart';
import 'package:kfupm_community_app/screens/welcome/widgets/footer_area.dart';
import 'package:kfupm_community_app/screens/welcome/widgets/header_logo.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkThemeColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              HeaderLogo(
                screenSize: screenSize,
              ),
              SizedBox(
                height: 100,
              ),
              BodyImage(
                screenSize: screenSize,
              ),
              SizedBox(
                height: screenSize.height * 0.14,
              ),
              FooterArea(
                screenSize: screenSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
