import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kfupm_community_app/screens/buysell/widgets/product_details_page.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:kfupm_community_app/utils/text_styles.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF191a19).withOpacity(0.3), // C9ECF8
            spreadRadius: 0.1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                    image: NetworkImage(
                      data['postUrl'],
                    ),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            data['title'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          Text(
            'Seller: ${data['username']}',
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'SAR ${data['price']}',
                    style: secondaryTextStyle,
                    overflow: TextOverflow.fade,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          data: data,
                        ),
                      ),
                    ),
                  },
                  child: Icon(
                    Icons.info_rounded,
                    color: primaryColor,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Posted on ${DateFormat.yMMMd().format(data['datePublished'].toDate())}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(
            height: 4,
          ),
        ],
      ),
    );
  }
}
