import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        height: context.size!.height,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [Text("Signup"), Text("create your account")],
            ),
          ),
        ),
      ),
    );
  }
}
