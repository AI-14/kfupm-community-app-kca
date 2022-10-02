import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/color_constants.dart';

class BodyImage extends StatelessWidget {
  final Size screenSize;
  const BodyImage({Key? key, required this.screenSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // We are using SizedBox as reference for positioning widgets after it.
        SizedBox(
          height: 300,
          width: 300,
        ),
        Positioned(
          top: -screenSize.height * 0.1,
          left: -screenSize.width * 0.2,
          child: CircleAvatar(
            backgroundColor: primaryColor,
            radius: 135.0,
            child: SvgPicture.asset(
              'assets/public_discussion.svg',
            ),
          ),
        ),
        Positioned(
          top: screenSize.height * 0.10,
          right: -screenSize.width * 0.2,
          child: CircleAvatar(
            backgroundColor: primaryColor,
            radius: 100.0,
            child: SvgPicture.asset(
              'assets/business_deal.svg',
            ),
          ),
        ),
        Positioned(
          top: screenSize.height * 0.25,
          left: screenSize.width * 0.03,
          child: CircleAvatar(
            backgroundColor: primaryColor,
            radius: 85.0,
            child: SvgPicture.asset(
              'assets/online_shopping.svg',
            ),
          ),
        ),
      ],
    );
  }
}
