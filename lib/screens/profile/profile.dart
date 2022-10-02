// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/user.dart';
// import 'package:kfupm_community_app/screens/home.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

Container container = Container(color: Colors.green, height: 20, width: 20);

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

Widget buildTextField(String labeltext, String placeholder) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextField(
        decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 15,
                color: Colors.lightGreenAccent,
                fontWeight: FontWeight.bold),
            labelText: labeltext,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            labelStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ))),
  );
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.lightGreenAccent;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 115, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'INFO'),
];

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    refreshUser();
  }

  void refreshUser() async {
    await Provider.of<UserProvider>(context, listen: false).refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Builder(builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });

          return Scaffold(
              backgroundColor: darkThemeColor,
              body: Stack(alignment: Alignment.center, children: [
                CustomPaint(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Consumer<UserProvider>(
                  builder: (context, provider, child) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width / 2.75,
                        height: MediaQuery.of(context).size.width / 2.75,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 3),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.75),
                              )
                            ],
                            color: Colors.white,
                            image: DecorationImage(
                              image:
                                  NetworkImage(provider.user!.profilePhotoUrl),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          provider.user!.username,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 1.25,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(1),
                        child: Text(
                          provider.user!.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 1.15,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      TabBar(
                        padding: EdgeInsets.only(top: 6),
                        // indicatorColor: Colors.lightGreenAccent,
                        labelColor: Colors.lightGreenAccent,
                        unselectedLabelColor: Colors.grey,
                        indicatorWeight: 3,
                        indicatorColor: Colors.lightGreenAccent,
                        indicatorSize: TabBarIndicatorSize.label,
                        // indicator: CircleTabIndicator(
                        //     color: Colors.lightGreenAccent, radius: 3),
                        tabs: const [
                          Tab(
                              text: 'USER INFO',
                              icon: Icon(Icons.accessibility_new_rounded)),
                          //Tab(text: 'ACTIVITY', icon: Icon(Icons.star)),
                        ],
                      ),
                      Expanded(
                        // padding: EdgeInsets.all(5),
                        // width: double.maxFinite,
                        // height: 200,
                        child: TabBarView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                              },
                              child: ListView(
                                // padding: const EdgeInsets.all(8),
                                children: [
                                  Text(''),
                                ],
                              ),
                            ),

                            // height: MediaQuery.of(context).size.height * 0.45,
                            // width: MediaQuery.of(context).size.width,
                            // ListWheelScrollView.useDelegate(
                            //   itemExtent: 100,
                            //   physics: FixedExtentScrollPhysics(),
                            //   perspective: 0.0001,
                            //   childDelegate: ListWheelChildBuilderDelegate(
                            //     childCount: 10,
                            //     builder: (context, index) {
                            //       return Card(
                            //         // padding: const EdgeInsets.all(20),
                            //         // height:
                            //         // MediaQuery.of(context).size.height * 0.4,
                            //         // width: MediaQuery.of(context).size.width,
                            //         // child: const FeedsCard(),
                            //       );
                            //     },
                            //   ),
                            // ),

                            // ListView.builder(
                            //   itemCount: 5,
                            //   itemBuilder: (context, index) {
                            //     return FeedsCard(
                            //       data: {
                            //         'username': 'johndoe123',
                            //         'userProfileUrl': defaultProfilePicUrl,
                            //         'likes': [],
                            //         'description': '',
                            //         'postUrl': defaultFeedsPostPic,
                            //       },
                            //     );
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.65,
                    left: MediaQuery.of(context).size.width * 0.60,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue.withOpacity(0.85),
                          child: IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.black,
                            onPressed: () {},
                            iconSize: 20,
                          ),
                        )))
              ]));
        }));
  }
}
