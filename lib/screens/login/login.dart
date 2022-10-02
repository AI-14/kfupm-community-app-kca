import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kfupm_community_app/firebase_backend/auth_methods.dart';
import 'package:kfupm_community_app/providers/home_screen_bottom_navbar.dart';
import 'package:kfupm_community_app/providers/login_screen_fields.dart';
import 'package:kfupm_community_app/screens/home/home.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return 'Email should not be empty!';
    } else if (email.length > 25) {
      return 'Email must be <= 25 characters.';
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Password should not be empty!';
    } else if (password.length < 6) {
      return 'Password length must be >= 6';
    } else {
      return null;
    }
  }

  void actionLoginButton(context) async {
    final logintextfieldsprovider =
        Provider.of<LoginScreenFieldsProvider>(context, listen: false);

    if (!formKey.currentState!.validate()) {
      return;
    }

    logintextfieldsprovider.setIsLoading(true);

    bool isLoginSuccessful = await AuthMethods().loginUser(
        email: emailTextController.text,
        password: passwordTextController.text,
        context: context);

    if (isLoginSuccessful) {
      Provider.of<HomeScreenBottomNavbarProvider>(context, listen: false)
          .setIndex(0);
      logintextfieldsprovider.setIsLoading(false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final LoginScreenFieldsProvider logintextfieldsprovider =
        Provider.of<LoginScreenFieldsProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: darkThemeColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: darkThemeColor,
      ),
      body: SafeArea(
        child: Container(
          height: screenSize.height,
          width: double.infinity,
          color: darkThemeColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // This box is used as a reference for other widgets to be positioned.
                    SizedBox(
                      width: screenSize.width * 0.45,
                      height: screenSize.height * 0.2,
                    ),
                    Positioned(
                      top: screenSize.width * 0.02,
                      left: -screenSize.height * 0.15,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFc7f2d3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * 0.02,
                      left: -screenSize.width * 0.09,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0xFFc7f2d3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * 0.12,
                      left: -screenSize.width * 0.2,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Color(0xFFc7f2d3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: screenSize.height * 0.030,
                      right: -screenSize.width * 0.5,
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 195.0,
                        child: SvgPicture.asset(
                          'assets/login_image.svg',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.32,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: screenSize.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFf7c600),
                            width: 2,
                          ),
                          color: Color(0xFFdaf0e8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateEmail(value),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: errorColor),
                            prefixIcon: Icon(
                              Icons.email_rounded,
                              color: primaryIconColor,
                            ),
                            hintText: 'Your email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        width: screenSize.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFFf7c600),
                            width: 2,
                          ),
                          color: Color(0xFFdaf0e8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Consumer<LoginScreenFieldsProvider>(
                          builder: (context, provider, child) {
                            return TextFormField(
                              controller: passwordTextController,
                              validator: (value) => validatePassword(value),
                              obscureText: provider.obscureTextPassword,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: primaryIconColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => logintextfieldsprovider
                                      .changeObscureTextPassword(),
                                  icon: provider.obscureTextPassword
                                      ? Icon(
                                          Icons.visibility_off_rounded,
                                          color: primaryIconColor,
                                        )
                                      : Icon(
                                          Icons.visibility_rounded,
                                          color: primaryIconColor,
                                        ),
                                ),
                                hintText: 'Your password',
                                border: InputBorder.none,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<LoginScreenFieldsProvider>(
                  builder: (context, provider, child) => Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: screenSize.width * 0.80,
                      height: screenSize.height * 0.065,
                      child: ElevatedButton(
                        onPressed: () => actionLoginButton(context),
                        child: provider.isLoading
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
