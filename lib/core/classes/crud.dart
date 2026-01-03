import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restapiproduct/core/error/exception.dart';

abstract class CrudInterface {
  Future<List> getAllData(String uri);
  Future<Map> getData(String uri);
  Future<Map> deleteData(String uri);
  Future<Map> updateData(String uri, Map<String, dynamic> data);
  Future<Map> insertData(String uri, Map<String, dynamic> data);
}

class CrudHttp implements CrudInterface {
  final http.Client client;
  CrudHttp({required this.client});

  @override
  Future<List> getAllData(String uri) async {
    final response = await client.get(
      Uri.parse(uri),
      headers: {'X-API-Key': "eb8d3a53b144b2ccdd7c68b07d4ab15c"},
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
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json', // مهم جداً
        'Accept': 'application/json',
      },
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
    final response = await client.delete(Uri.parse(uri));
    if (response.statusCode == 200) {
      final Map responseBody = jsonDecode(response.body) as Map;
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map> getData(String uri) async {
    final response = await client.get(Uri.parse(uri));
    if (response.statusCode == 200) {
      final Map responseBody = jsonDecode(response.body) as Map;
      return responseBody;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Map> updateData(String uri, Map<String, dynamic> data) async {
    final response = await client.patch(Uri.parse(uri), body: jsonEncode(data));
    if (response.statusCode == 200) {
      final Map responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      throw ServerException();
    }
  }
}
