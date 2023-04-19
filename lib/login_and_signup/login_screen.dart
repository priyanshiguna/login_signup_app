import 'package:flutter/material.dart';
import 'package:second_screens_app/login_and_signup/signup_screen.dart';

import '../app_common/app_textfeild_common.dart';

class LogInPage extends StatefulWidget {
  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  static final RegExp numberRegExp = RegExp(r'\d');
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visiblePassword = false;

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
      body: Form(
        key: formKey,
        child: Padding(
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
                validator: (value) {
                  if (RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!)) {
                    return "";
                  } else {
                    return "Please enter valid email";
                  }
                },
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
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Password is required';
                  }
                  return "";
                },
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  formKey.currentState!.validate();
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
                          builder: (context) => const SignUpPage(),
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
      ),
    );
  }
}
