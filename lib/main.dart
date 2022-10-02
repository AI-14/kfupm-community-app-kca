import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kfupm_community_app/providers/add_feeds_post.dart';
import 'package:kfupm_community_app/providers/buysell_screen_category.dart';
import 'package:kfupm_community_app/providers/home_screen_bottom_navbar.dart';
import 'package:kfupm_community_app/providers/login_screen_fields.dart';
import 'package:kfupm_community_app/providers/sell_product_post.dart';
import 'package:kfupm_community_app/providers/signup_screen_fields.dart';
import 'package:kfupm_community_app/providers/user.dart';
import 'package:kfupm_community_app/screens/welcome/welcome.dart';
import 'package:provider/provider.dart';

void main() async {
  // Next 2 lines are for initializing the backend services.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider<LoginScreenFieldsProvider>(
          create: (_) => LoginScreenFieldsProvider(),
        ),
        ChangeNotifierProvider<SignupScreenFieldsProvider>(
          create: (_) => SignupScreenFieldsProvider(),
        ),
        ChangeNotifierProvider<HomeScreenBottomNavbarProvider>(
          create: (_) => HomeScreenBottomNavbarProvider(),
        ),
        ChangeNotifierProvider<AddFeedsPostProvider>(
          create: (_) => AddFeedsPostProvider(),
        ),
        ChangeNotifierProvider<SellProductPostProvider>(
          create: (_) => SellProductPostProvider(),
        ),
        ChangeNotifierProvider<BuySellScreenCategoryProvider>(
          create: (_) => BuySellScreenCategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KFUPM Community App',
        home: WelcomeScreen(),
      ),
    );
  }
}
