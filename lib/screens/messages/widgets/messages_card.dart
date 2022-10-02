import 'package:flutter/material.dart';

class MessagesCard extends StatelessWidget {
  const MessagesCard({
    Key? key,
    required this.sellerProfileUrl,
    required this.sellerUsername,
    required this.press,
  }) : super(key: key);

  final VoidCallback press;
  final sellerProfileUrl, sellerUsername;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(sellerProfileUrl),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sellerUsername,
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.5,
                        color: Colors.lightGreenAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Tap to view.",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Text(
            //   "5:05 PM",
            //   style: TextStyle(
            //     fontSize: 12,
            //     letterSpacing: 1.1,
            //     color: Colors.lightGreenAccent,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
