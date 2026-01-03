import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapiproduct/feature/products/presentation/screen/products_screen.dart';

import '../controller/cubit/products_cubit.dart';

class AddProductScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController(
    text: "0",
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blueAccent,
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                    autofocus: true,
                    controller: _nameController,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Price is required";
                      }
                      return null;
                    },
                    controller: _priceController,
                  ),
                  Row(
                    children: [
                      BlocSelector<ProductsCubit, ProductsState, bool>(
                        selector: (state) => state.isAvailable,
                        builder: (context, isAvailable) => Checkbox(
                          value: isAvailable,
                          onChanged: (value) {
                            context.read<ProductsCubit>().isAvailable(value!);
                          },
                        ),
                      ),
                      Text("Is Available"),
                    ],
                  ),
                  BlocListener<ProductsCubit, ProductsState>(
                    listener: (context, state) {
                      if (state.messageSuccess.isNotEmpty) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductsScreen(),
                          ),
                          (route) => false,
                        );
                      }
                      if (state.messageError.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.messageError)),
                        );
                      }
                    },
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ProductsCubit>().addProduct(
                            name: _nameController.text,
                            price: int.parse(_priceController.text),
                          );
                        }
                      },
                      child: Text("Add Product"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
