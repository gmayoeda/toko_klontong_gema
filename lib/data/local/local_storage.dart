import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StatusLoginPreferences {
  StatusLoginPreferences._();
  static const FlutterSecureStorage storage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));

  static Future<void> setStatusLogin(newValue) async {
    await storage.write(key: 'statusLogin', value: newValue);
  }

  static Future<String?> getStatusLogin() async {
    String? statusLogin = await storage.read(key: "statusLogin");
    return statusLogin;
  }
}
