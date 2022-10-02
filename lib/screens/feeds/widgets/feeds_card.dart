import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kfupm_community_app/screens/feeds/widgets/comment_page.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:kfupm_community_app/utils/text_styles.dart';
import 'package:readmore/readmore.dart';

class FeedsCard extends StatefulWidget {
  const FeedsCard({Key? key, required this.data}) : super(key: key);

  final data; // QueryDocumentSnapshot<Map<String, dynamic>>

  @override
  State<FeedsCard> createState() => _FeedsCardState();
}

class _FeedsCardState extends State<FeedsCard> {
  int commentLength = 0;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getComments() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('feedsposts')
        .doc(widget.data['postId'])
        .collection('comments')
        .get();

    setState(() {
      commentLength = snap.docs.length;
    });
  }

  void actionAllCommentsButton(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsPage(
          postId: widget.data['postId'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Header section.
          Row(
            children: <Widget>[
              SizedBox(
                width: 4,
              ),
              Container(
                margin: EdgeInsets.only(left: 2),
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: Color(0xff7c94b6),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.data['userProfileUrl'],
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  border: Border.all(
                    color: Colors.blueGrey,
                    width: 1.0,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.data['username'],
                  style: primaryTextStyle,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),

          // Image section.
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
              image: DecorationImage(
                image: NetworkImage(widget.data['postUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(
            height: 10,
          ),

          // Comment section.
          Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  actionAllCommentsButton(context);
                },
                icon: Icon(
                  Icons.comment_outlined,
                  color: primaryColor,
                  size: 20,
                ),
              ),
              Text(
                '${commentLength}',
                style: secondaryTextStyle,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                  'Posted on ${DateFormat.yMMMd().format(widget.data['datePublished'].toDate())}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 8,
          ),

          // Description text.
          ReadMoreText(
            widget.data['description'],
            trimLines: 2,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Show more',
            trimExpandedText: 'Show less',
            moreStyle: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            lessStyle: TextStyle(
              color: Colors.green,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
            delimiter: ' ',
          ),

          Divider(
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
