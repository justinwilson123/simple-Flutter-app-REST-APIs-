import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:restapiproduct/core/classes/save_secure_storage.dart';
import 'package:restapiproduct/feature/products/presentation/screen/update_product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/cubit/products_cubit.dart';
import 'add_product_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().getAllPoduct();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        leading: IconButton(
          onPressed: () async {
            final sharedPreference = await SharedPreferences.getInstance();
            final saveSecute = FlutterSecureStorage();
            await sharedPreference.clear();
            await saveSecute.deleteAll();
          },
          icon: Icon(Icons.logout),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state.messageSuccess.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messageSuccess),
                backgroundColor: Colors.greenAccent,
              ),
            );
          }
          if (state.messageError.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.messageError),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else if (!state.isLoading && state.products.isNotEmpty) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.price.toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateProductScreen(product: product),
                        ),
                      );
                    },
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<ProductsCubit>().deleteOneProduct(
                        product.id!,
                      );
                    },
                  ),
                );
              },
            );
          } else if (state.messageError.isNotEmpty) {
            return Center(child: Text(state.messageError));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
