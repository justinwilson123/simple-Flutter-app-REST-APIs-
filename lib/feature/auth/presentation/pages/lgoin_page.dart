import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapiproduct/feature/auth/presentation/controllers/login/login_cubit.dart';
import 'package:restapiproduct/feature/auth/presentation/widgets/form_filed_widget.dart';
import 'package:restapiproduct/feature/products/presentation/screen/products_screen.dart';

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
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
          if (state.successMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage),
                backgroundColor: Colors.greenAccent,
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => ProductsScreen()),
              (root) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SafeArea(
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
                    FormFiledWidget(
                      controller: _email,
                      validator: (valure) {
                        if (valure!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      icon: Icon(Icons.email),
                      hintText: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    FormFiledWidget(
                      controller: _password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: false,
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
                      child: ElevatedButton(
                        onPressed: () {
                          if (_myKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(
                              _email.text,
                              _password.text,
                            );
                          }
                        },
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
