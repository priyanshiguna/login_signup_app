import 'package:flutter/material.dart';

import '../app_common/app_textfeild_common.dart';
import 'login_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkBoxData = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFAF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFEFAF4),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Hey there! Sign up with your email to continue.",
                    style: TextStyle(
                      color: Color(0xFF8C8A87),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(height: 40),
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
                    "Referral code (optional)",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Inter",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFieldScreen(
                    controller: referralCodeController,
                    textInputAction: TextInputAction.done,
                    hintText: "Enter referral code",
                    hidePassword: const SizedBox(),
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Code Optional';
                      }
                      return "";
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
                    obscureText: !visiblePassword,
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password Too Short';
                      }
                      return "";
                    },
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: const [
                      Image(image: AssetImage("assets/images/Info.png")),
                      SizedBox(width: 10),
                      Text(
                        "Password must be more than 8 characters.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Image(image: AssetImage("assets/images/Info.png")),
                      SizedBox(width: 10),
                      Text(
                        "Password must contain a mix of uppercase,\nlowercase, numbers and special characters.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: checkBoxData,
                      shape: const CircleBorder(),
                      splashRadius: 0,
                      fillColor:
                          MaterialStateProperty.all(const Color(0xFF000000)),
                      onChanged: (data) {
                        checkBoxData = data!;
                        setState(() {});
                      },
                    ),
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 36),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I have read and agree to the',
                          style: TextStyle(
                            fontFamily: "Inter",
                            color: Color(0xFF000000),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            fontFamily: "Inter",
                            color: Color(0xFF000000),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      formKey.currentState!.validate();
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(0xFF9D9B97)),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Get Started",
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
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Having issues>",
                      style: TextStyle(
                        color: Color(0xFFEE9136),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
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
                              builder: (context) => const LogInPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "  Log In",
                          style: TextStyle(
                              fontFamily: "Inter",
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
