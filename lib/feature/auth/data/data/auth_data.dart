import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:restapiproduct/core/classes/crud.dart';
import 'package:restapiproduct/feature/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';

abstract class RemoteDataSourceAuth {
  Future<Unit> sginup(UserModel user);
  Future<Map<String, dynamic>> login(String email, String password);
  Future<String> profile();
  Future<Unit> logout();
}

const BASEURL = "http://192.168.1.7";

class RemoteDataSourceAuthWithHttp implements RemoteDataSourceAuth {
  final http.Client client;
  final CrudInterface crud;
  RemoteDataSourceAuthWithHttp({required this.crud, required this.client});

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> data = {"email": email, "password": password};
    final response = await client.post(Uri.parse('$BASEURL/login'), body: data);
    if (response.statusCode == 201) {
      final Map<String, dynamic> user =
          jsonDecode(response.body) as Map<String, dynamic>;

      return user;
    } else if (response.statusCode == 404) {
      throw EmailNotCorrectException();
    } else {
      throw ServerException();
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
      print(response['API-key']);
      return response['API-key'];
    } else {
      throw SomethingNotCorrectExeption();
    }
  }

  @override
  Future<Unit> sginup(UserModel user) async {
    final response = await client.post(
      Uri.parse('$BASEURL/signup'),
      body: user.toJson(),
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 422) {
      throw EmailUseingException();
    } else {
      throw ServerException();
    }
    // final response = await crud.insertData("$BASEURL/signup", user.toJson());
    // if (response['message'] == "success") {
    //   return Future.value(unit);
    // } else {
    //   throw EmailUseingException();
    // }
  }
}
