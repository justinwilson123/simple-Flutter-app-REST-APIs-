import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restapiproduct/core/error/exception.dart';

import 'save_secure_storage.dart';

abstract class CrudInterface {
  Future<List> getAllData(String uri);
  Future<Map> getData(String uri);
  Future<Map> deleteData(String uri);
  Future<Map> updateData(String uri, Map<String, dynamic> data);
  Future<Map> insertData(String uri, Map<String, dynamic> data);
}

class CrudHttp implements CrudInterface {
  final http.Client client;
  final SaveSecureStorage saveSecureStorage;
  CrudHttp({required this.client, required this.saveSecureStorage}) {
    _getApikey();
  }
  String? apikey;
  _getApikey() async {
    apikey = await saveSecureStorage.getToken();
    return apikey!;
  }

  @override
  Future<List> getAllData(String uri) async {
    final response = await client.get(
      Uri.parse(uri),
      headers: {'X-API-Key': apikey!},
    );
    if (response.statusCode == 200) {
      final List responseBody = jsonDecode(response.body) as List;
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map> insertData(String uri, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse(uri),
      body: data,
      headers: {'X-API-Key': apikey!},
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      final Map responseBody = jsonDecode(response.body) as Map;
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map> deleteData(String uri) async {
    final response = await client.delete(
      Uri.parse(uri),
      headers: {'X-API-Key': apikey!},
    );
    if (response.statusCode == 200) {
      final Map responseBody = jsonDecode(response.body) as Map;
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map> getData(String uri) async {
    final response = await client.get(
      Uri.parse(uri),
      headers: {'X-API-Key': apikey!},
    );
    if (response.statusCode == 200) {
      final Map responseBody = jsonDecode(response.body) as Map;
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map> updateData(String uri, Map<String, dynamic> data) async {
    final response = await client.patch(
      Uri.parse(uri),
      body: data,
      headers: {'X-API-Key': apikey!},
    );
    if (response.statusCode == 200) {
      final Map responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      throw ServerException();
    }
  }
}
