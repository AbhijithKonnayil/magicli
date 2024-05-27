import 'dart:io';

import 'package:path/path.dart' as path;

class Utils {
  static const libFolder = 'del';
  static Future<bool> isDartProjectRoot() async {
    String pwd = await getPwd();
    if (doesFolderExist("$pwd/pubspec.yaml")) {
      print("Flutter root");
      return true;
    } else {
      print("Not Flutter root");
      return false;
    }
  }

  static Future<bool> isLibFolderPresent() async {
    String pwd = await getPwd();
    if (doesFolderExist("$pwd/$libFolder")) {
      print("lib exist");
      return true;
    }
    print("lib not found");
    return false;
  }

  static bool doesFolderExist(String path) {
    return Directory(path).existsSync();
  }

  static Future<String> getPwd() async {
    ProcessResult result = await Process.run('pwd', []);
    return result.stdout.trim();
  }

  static Future<Directory?> getLibDir() async {
    if (await isDartProjectRoot() && await isLibFolderPresent()) {
      String pwd = await getPwd();
      return Directory("$pwd/$libFolder");
    }
    print("Lib not found");
  }

  static File createFile(Directory directory, String fileName) {
    return File(path.join(directory.path, fileName))..createSync();
  }
}

String snakeCaseToProperCase(String input) {
  return input.split('_').map((word) {
    if (word.isEmpty) {
      return '';
    }
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join('');
}
