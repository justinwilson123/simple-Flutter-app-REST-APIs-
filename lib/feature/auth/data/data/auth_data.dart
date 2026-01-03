import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/classes/crud.dart';
import 'package:restapiproduct/feature/auth/data/models/user_model.dart';

import '../../../../core/error/exception.dart';

abstract class RemoteDataSourceAuth {
  Future<Unit> sginup(UserModel user);
  Future<int> login(String email, String password);
  Future<String> profile();
  Future<Unit> logout();
}

const BASEURL = "http://192.168.1.7";

class RemoteDataSourceWithHttp implements RemoteDataSourceAuth {
  final CrudHttp crud;
  RemoteDataSourceWithHttp({required this.crud});

  @override
  Future<int> login(String email, String password) async {
    final Map<String, dynamic> data = {"email": email, "password": password};
    final response = await crud.insertData('$BASEURL/login', data);
    if (response['message'] == "success") {
      final int userId = response["userId"] as int;
      return Future.value(userId);
    } else {
      throw EmailNotCorrectException();
    }
  }

  @override
  Future<Unit> logout() async {
    final response = await crud.getData("$BASEURL/logout");
    if (response['message'] == "success") {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> profile() async {
    final response = await crud.getData("$BASEURL/profile");
    if (response['message'] == "success") {
      return response['API-key'];
    } else {
      throw SomethingNotCorrectExeption();
    }
  }

  @override
  Future<Unit> sginup(UserModel user) async {
    final response = await crud.insertData("$BASEURL/signup", user.toJson());
    if (response['message'] == "success") {
      return Future.value(unit);
    } else {
      throw EmailUseingException();
    }
  }
}
