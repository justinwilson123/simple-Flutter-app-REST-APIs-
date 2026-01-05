import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapiproduct/feature/auth/domain/entity/user_entity.dart';
import 'package:restapiproduct/feature/auth/presentation/controllers/signup/signup_cubit.dart';
import 'package:restapiproduct/feature/auth/presentation/widgets/form_filed_widget.dart';

import 'lgoin_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _mykey = GlobalKey<FormState>();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: BlocListener<SignupCubit, SignupState>(
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
              MaterialPageRoute(builder: (_) => LoginPage()),
              (root) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: height,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SafeArea(
              child: Form(
                key: _mykey,
                child: Column(
                  children: [
                    Text(
                      "Signup",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      "create your account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    FlutterLogo(size: 200),
                    FormFiledWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        }
                        return null;
                      },
                      controller: _name,
                      hintText: "Name",
                      icon: Icon(Icons.person),
                    ),
                    FormFiledWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        }
                        return null;
                      },
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "email",
                      icon: Icon(Icons.email),
                    ),
                    BlocSelector<SignupCubit, SignupState, bool>(
                      selector: (state) => state.showPass,
                      builder: (context, showPass) {
                        return FormFiledWidget(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          controller: _password,
                          hintText: "password",
                          obscureText: showPass,
                          icon: IconButton(
                            onPressed: () {
                              context.read<SignupCubit>().showHidePass();
                            },
                            icon: Icon(Icons.lock),
                          ),
                        );
                      },
                    ),
                    BlocSelector<SignupCubit, SignupState, bool>(
                      selector: (state) {
                        return state.showRepass;
                      },
                      builder: (context, showRepass) {
                        return FormFiledWidget(
                          obscureText: showRepass,
                          validator: (value) {
                            if (_password.text != value) {
                              return "Password not match";
                            }
                            return null;
                          },
                          controller: _confirmPassword,
                          hintText: "confirm password",
                          icon: IconButton(
                            onPressed: () {
                              context.read<SignupCubit>().showHideRepass();
                            },
                            icon: Icon(Icons.lock),
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          "do you have an account?  ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                              (root) => false,
                            );
                          },
                          child: Text("Login"),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        if (_mykey.currentState!.validate()) {
                          final user = UserEntity(
                            name: _name.text,
                            email: _email.text,
                            password: _password.text,
                            repassword: _confirmPassword.text,
                          );
                          context.read<SignupCubit>().signup(user);
                        }
                      },
                      child: Text("Signup"),
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
