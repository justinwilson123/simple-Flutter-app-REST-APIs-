import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restapiproduct/feature/products/domain/entity/product_entity.dart';

import '../controller/cubit/products_cubit.dart';
import 'products_screen.dart';

class UpdateProductScreen extends StatelessWidget {
  final ProductEntity product;
  late final TextEditingController _nameController = TextEditingController(
    text: product.name,
  );
  late final TextEditingController _priceController = TextEditingController(
    text: product.price.toString(),
  );
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UpdateProductScreen({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().isAvailable(product.isAvailable!);
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
                          context.read<ProductsCubit>().updateProdcut(
                            id: product.id!,
                            name: _nameController.text,
                            price: _priceController.text,
                          );
                        }
                      },
                      child: Text("Update Product"),
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
