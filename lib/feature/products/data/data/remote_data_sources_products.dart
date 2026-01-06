import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/classes/crud.dart';
import 'package:restapiproduct/core/error/exception.dart';
import '../models/products_model.dart';

abstract class RemoteDataSourceProducts {
  Future<List<ProductsModel>> getAllProduct();
  Future<ProductsModel> getProductById(int id);
  Future<Unit> updateProduct(int id, ProductsModel product);
  Future<Unit> addProduct(ProductsModel product);
  Future<Unit> deleteProduct(int id);
}

const BASEURL = "http://192.168.1.7/api/products";

class RemoteDataSourcesProductsImp implements RemoteDataSourceProducts {
  final CrudInterface crud;
  RemoteDataSourcesProductsImp({required this.crud});

  @override
  Future<List<ProductsModel>> getAllProduct() async {
    final response = await crud.getAllData(BASEURL);
    if (response.isEmpty) {
      throw NoDataException();
    } else {
      return response.map((e) => ProductsModel.fromJson(e)).toList();
    }
  }

  @override
  Future<Unit> addProduct(ProductsModel product) async {
    final response = await crud.insertData(BASEURL, product.toJson());

    if (response['message'] == "product created") {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deleteProduct(int id) async {
    final response = await crud.deleteData("$BASEURL/${id.toString()}");
    if (response['message'] == "product deleted") {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductsModel> getProductById(int id) async {
    final result = await crud.getData("$BASEURL/${id.toString()}");
    if (result["message"] == "product not found") {
      throw NoDataException();
    } else {
      final Map<String, dynamic> product =
          result["data"] as Map<String, dynamic>;
      return ProductsModel.fromJson(product);
    }
  }

  @override
  Future<Unit> updateProduct(int id, ProductsModel product) async {
    final data = product.toJson();
    final result = await crud.updateData("$BASEURL/${id.toString()}", data);
    if (result["message"] == "product updated") {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
