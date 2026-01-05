import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapiproduct/feature/auth/presentation/controllers/login/login_cubit.dart';
import 'package:restapiproduct/feature/auth/presentation/pages/lgoin_page.dart';

import 'feature/products/presentation/controller/cubit/products_cubit.dart';
import 'feature/products/presentation/screen/products_screen.dart';
import 'conatiner.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<LoginCubit>()..getIsLogin()),
        BlocProvider(create: (_) => di.sl<ProductsCubit>()),
      ],
      child:
          //  MaterialApp(home: ProductsScreen()),
          BlocSelector<LoginCubit, LoginState, bool>(
            selector: (state) {
              return state.isLogin;
            },
            builder: (context, isLogin) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: isLogin ? ProductsScreen() : LoginPage(),
              );
            },
          ),
    );
  }
}
