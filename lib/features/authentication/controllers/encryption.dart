import 'package:encrypt/encrypt.dart';

class EncryptData {
  // for AES Algorithms

  static Encrypted? encrypted;
  static String? decrypted; // Changed the type to String

  static Encrypted? encryptAES(String plainText, String keyw) {
    String extractedString = keyw.substring(0, 32);
    final key = Key.fromUtf8('$extractedString');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    encrypted = encrypter.encrypt(plainText, iv: iv);
    print(encrypted?.base64);
    return encrypted;
    // Added a null check with '?'
  }

  // static decryptAES(Encrypted? hashedpass, String keyw) {
  //   final key = Key.fromUtf8('$keyw');
  //   final iv = IV.fromLength(16);
  //   final encrypter = Encrypter(AES(key));
  //   if (encrypted != null) {
  //     decrypted = encrypter.decrypt(hashedpass!, iv: iv);
  //     print(decrypted);
  //   } else {
  //     print('No data to decrypt.');
  //   }
  // }
}
