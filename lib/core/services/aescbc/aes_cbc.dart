import 'package:encrypt/encrypt.dart';

class AESAlgorithm {
  String decrypt(String encrypted, String keyIn, String ivIn) {
    final key = Key.fromUtf8(keyIn);
    final iv = IV.fromUtf8(ivIn);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final enBase64 = Encrypted.from64(encrypted);
    final decrypted = encrypter.decrypt(enBase64, iv: iv);
    return decrypted;
  }

  String encrypt(String value, String keyIn, String ivIn) {
    final key = Key.fromUtf8(keyIn);
    final iv = IV.fromUtf8(ivIn);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(value, iv: iv);
    return encrypted.base64;
  }
}
