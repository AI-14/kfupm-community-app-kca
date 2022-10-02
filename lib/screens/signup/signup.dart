import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kfupm_community_app/firebase_backend/auth_methods.dart';
import 'package:kfupm_community_app/screens/login/login.dart';
import 'package:kfupm_community_app/screens/signup/widgets/upload_photo_area.dart';
import 'package:kfupm_community_app/screens/signup/widgets/webview_auth.dart';
import 'package:kfupm_community_app/utils/color_constants.dart';
import 'package:provider/provider.dart';

import '../../providers/signup_screen_fields.dart';
import '../../utils/helper.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  String? validateUsername(String? username) {
    if (username!.isEmpty) {
      return 'Username should not be empty!';
    } else if (username.length > 10) {
      return 'Username must be <= 10 characters.';
    } else {
      return null;
    }
  }

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

  String? validateConfirmPassword(String? confirmpassword) {
    if (confirmpassword!.isEmpty) {
      return 'Password should not be empty!';
    } else if (confirmpassword.length < 6) {
      return 'Password length must be >= 6';
    } else if (confirmpassword != passwordTextController.text) {
      return 'Password mismatch!';
    } else {
      return null;
    }
  }

  void actionSignupButton(context) async {
    final signUpfieldsprovider =
        Provider.of<SignupScreenFieldsProvider>(context, listen: false);

    if (!formKey.currentState!.validate() &&
        signUpfieldsprovider.photoFile == null) {
      Utils.showSnackbar(
          context, 'Image and fields are required!', SnackBarType.Warning);
      return;
    } else {
      // Authenticate the user via KFUPM CAS.
      bool kfupmAuthenticated = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => KFUPMAuth(),
        ),
      );

      signUpfieldsprovider.setIsLoading(true);
      bool savedToDbSuccessful = await AuthMethods().signUpUser(
          username: usernameTextController.text,
          email: emailTextController.text,
          password: passwordTextController.text,
          profilePhotoFile:
              Provider.of<SignupScreenFieldsProvider>(context, listen: false)
                  .photoFile!,
          context: context);

      if (kfupmAuthenticated && savedToDbSuccessful) {
        signUpfieldsprovider.setIsLoading(false);
        Utils.showSnackbar(context, 'Signup successful. Now you may Login.',
            SnackBarType.Success);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        signUpfieldsprovider.setIsLoading(false);
        Utils.showSnackbar(
            context,
            'Internal error occured or Invalid KFUPM member!',
            SnackBarType.Error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final SignupScreenFieldsProvider signupScreenFields =
        Provider.of<SignupScreenFieldsProvider>(context, listen: false);

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
                UploadPhotoArea(
                  screenSize: screenSize,
                ),
                SizedBox(
                  height: screenSize.height * 0.02,
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
                          controller: usernameTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validateUsername(value),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(color: errorColor),
                            prefixIcon: Icon(
                              Icons.person,
                              color: primaryIconColor,
                            ),
                            hintText: 'Your username',
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
                        child: Consumer<SignupScreenFieldsProvider>(
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
                                  onPressed: () => signupScreenFields
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
                        child: Consumer<SignupScreenFieldsProvider>(
                          builder: (context, provider, child) {
                            return TextFormField(
                              controller: confirmPasswordTextController,
                              validator: (value) =>
                                  validateConfirmPassword(value),
                              obscureText: provider.obscureTextConfirmPassword,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_rounded,
                                  color: primaryIconColor,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () => signupScreenFields
                                      .changeObscureTextConfirmPassword(),
                                  icon: provider.obscureTextConfirmPassword
                                      ? Icon(
                                          Icons.visibility_off_rounded,
                                          color: primaryIconColor,
                                        )
                                      : Icon(
                                          Icons.visibility_rounded,
                                          color: primaryIconColor,
                                        ),
                                ),
                                hintText: 'Confirm your password',
                                border: InputBorder.none,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Consumer<SignupScreenFieldsProvider>(
                  builder: (context, provider, child) => Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: screenSize.width * 0.80,
                      height: screenSize.height * 0.065,
                      child: ElevatedButton(
                        onPressed: () => actionSignupButton(context),
                        child: provider.isLoading
                            ? SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'SIGNUP',
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
                SizedBox(
                  height: screenSize.height * 0.05,
                ),
                CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 70.0,
                  child: SvgPicture.asset(
                    'assets/signup_image.svg',
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
