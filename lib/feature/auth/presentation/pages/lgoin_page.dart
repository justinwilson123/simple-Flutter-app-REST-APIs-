import 'package:flutter/material.dart';
import 'package:restapiproduct/feature/auth/presentation/widgets/form_filed_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          key: _myKey,
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              Text(
                "Welcom back",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              FlutterLogo(size: 200),
              // Spacer(),
              FormFiledWidget(
                icon: Icon(Icons.email),
                hintText: "Enter your email",
              ),
              FormFiledWidget(
                icon: Icon(Icons.lock),
                hintText: "Enter your password",
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    "do not have an account?  ",
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextButton(onPressed: () {}, child: Text("Signup")),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(onPressed: () {}, child: Text("Login")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
