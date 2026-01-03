import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SaveSecureStorage {
  final FlutterSecureStorage storage;

  SaveSecureStorage({required this.storage});

  Future<void> saveToken(String token) async {
    await storage.write(key: "TOKEN", value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "TOKEN");
  }
}
