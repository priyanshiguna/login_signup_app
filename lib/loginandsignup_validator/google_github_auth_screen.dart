import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleGithubAuth extends StatefulWidget {
  const GoogleGithubAuth({Key? key}) : super(key: key);

  @override
  State<GoogleGithubAuth> createState() => _GoogleGithubAuthState();
}

class _GoogleGithubAuthState extends State<GoogleGithubAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  signInWithGoogle();
                },
                child: const Text("Google Auth")),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () {
                  signInWithGitHub();
                },
                child: const Text("GitHub Auth"))
          ],
        ),
      ),
    );
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signInWithGitHub() async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
        clientId: "454df28e9db24c40f58f",
        clientSecret: "7c12f9d9d1eaf0bf4006cd9d58a2a87e05f57a2a",
        redirectUrl:
            'https://login-signup-app-183d1.firebaseapp.com/__/auth/handler');
    final result = await gitHubSignIn.signIn(context);
    final githubAuthCredential = GithubAuthProvider.credential(result.token!);
    return await FirebaseAuth.instance
        .signInWithCredential(githubAuthCredential);
  }
}
