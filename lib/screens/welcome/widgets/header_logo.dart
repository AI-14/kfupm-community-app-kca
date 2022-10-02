import 'package:flutter/material.dart';

class HeaderLogo extends StatelessWidget {
  final Size screenSize;
  const HeaderLogo({Key? key, required this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'kfupm_logo_rec.png',
          width: screenSize.width * 0.95,
          height: screenSize.height * 0.09,
        ),
      ],
    );
  }
}
