import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_screens_app/loginandsignup_validator/signup_page_screen.dart';

import '../app_common/app_textfeild_common.dart';

class LogInUpdatePage extends StatefulWidget {
  const LogInUpdatePage({Key? key}) : super(key: key);

  @override
  State<LogInUpdatePage> createState() => _LogInUpdatePageState();
}

class _LogInUpdatePageState extends State<LogInUpdatePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visiblePassword = false;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? userCredential;
  dynamic value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFAF4),
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          size: 25,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 40),
            const Text(
              "Welcome back",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Sign in with your email to continue.",
              style: TextStyle(
                color: Color(0xFF8C8A87),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              "Your email",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 10),
            TextFieldScreen(
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              hintText: "Email",
              hidePassword: const SizedBox(),
            ),
            const SizedBox(height: 20),
            const Text(
              "Your password",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(height: 10),
            TextFieldScreen(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              hintText: "Enter your password",
              obscureText: !visiblePassword,
              hidePassword: IconButton(
                onPressed: () {
                  setState(() {
                    visiblePassword = !visiblePassword;
                  });
                },
                icon: Icon(
                  visiblePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 25,
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                if (validator()) {
                  debugPrint("Successfully Login");
                } else {
                  userLogin();
                }
              },
              child: Container(
                height: 55,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  color: Color(0xFFEE9136),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                ),
              ),
            ),
            const SizedBox(height: 130),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12,
                      color: Color(0x59000000),
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpUpdatePage(),
                      ),
                    );
                  },
                  child: const Text(
                    "  Sign Up",
                    style: TextStyle(
                        fontFamily: "Inter",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  showToastMessage(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black26,
      fontSize: 16.0,
    );
  }

  bool validator() {
    if (emailController.text.isEmpty) {
      showToastMessage("Please enter email");
      return false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      showToastMessage("Please enter valid email");
      return false;
    } else if (passwordController.text.isEmpty) {
      showToastMessage("Please enter password");
      return false;
    } else if (!RegExp(
            "^(?=.*[A-Z].*[A-Z])(?=.*[!@#\$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}")
        .hasMatch(passwordController.text)) {
      showToastMessage("Please enter valid password");
    } else {
      return false;
    }
    return true;
  }

  userLogin() async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        userCredential = value.user;
        debugPrint("User Data --> ${value.user}");
        if (value.user!.emailVerified) {
          debugPrint("User has Login --> ");
        } else {
          showDialogue();
        }
        setState(() {});
      });
    } on FirebaseAuthException catch (error) {
      showToastMessage("Error Code --->>>${error.code}");
    }
  }

  showDialogue() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          height: 150,
          width: 150,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your Email was Not Verified!! \n-->If you Want to verify yor Email please press RESEND button",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    const SizedBox(width: 30),
                    ElevatedButton(
                        onPressed: () {
                          userCredential!.sendEmailVerification();
                          setState(() {});
                        },
                        child: const Text("Resend"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
