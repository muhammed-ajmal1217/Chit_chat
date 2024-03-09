import 'package:chitchat/controller/auth_provider.dart';
import 'package:chitchat/helpers/helpers.dart';
import 'package:chitchat/main_widgets/main_auth_button.dart';
import 'package:chitchat/main_widgets/bacground_ellipse.dart';
import 'package:chitchat/main_widgets/toggle_signup_login.dart';
import 'package:chitchat/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback showLogin;
  
  SignUpPage({Key? key, required this.showLogin});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff3A487A),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.black,
          child: Stack(
            children: [
              Ellipses(),
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.10,
                  left: width * 0.05,
                  right: width * 0.05,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      spacingHeight(height * 0.01),
                      titlesofAuth(
                        screenHeight: height,
                        title: "Create new\nAccount\nSign-up with\nEmail"
                      ),
                      spacingHeight(height * 0.02),
                      textFields(controller: nameController,text: 'Name', fontSize: 13),
                      spacingHeight(height * 0.02),
                      textFields(controller: emailController,text: 'E-mail', fontSize: 13),
                      spacingHeight(height * 0.01),
                      Text(
                        "Password must include 8 characters",
                        style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: height * 0.013,
                        ),
                      ),
                      spacingHeight(height * 0.01),
                      textFields(controller: passwordController,text: 'Create password', fontSize: 13),
                      spacingHeight(height * 0.02),
                      textFields(controller: confirmController,text: 'Confirm password', fontSize: 13),
                      spacingHeight(height * 0.01),
                      ToggleScreen(
                        screenHeight: height,
                        screenWidth: width,
                        toggleScreen: () => widget.showLogin(),
                        text1: 'login with an existing account',
                        text2: 'Login',
                      ),
                      spacingHeight(height * 0.02),
                      MainButtons(
                        screenHeight: height,
                        screenWidth: width,
                        text: 'Sign up',
                        onPressed: () {
                          signUp();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
@override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }
  void signUp(){
    final authProvider=Provider.of<AuthenticationProvider>(context,listen: false);
    if(passwordController.text!=confirmController.text){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pssword not matching'))
      );
    }else{
      authProvider.signupWithEmail(email: emailController.text.trim(), password: passwordController.text.trim(), userName: nameController.text.trim());
    }
  }

}
