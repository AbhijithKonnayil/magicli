import 'dart:io';

import 'package:magicli/utils/color_print.dart';
import 'package:path/path.dart' as path;

class Utils {
  static const libFolder = 'del';
  static Future<bool> isDartProjectRoot() async {
    String pwd = await getPwd();
    print(pwd);
    if (doesFileExist("$pwd/pubspec.yaml")) {
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

  static bool doesFileExist(String path) {
    return File(path).existsSync();
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

  static void writeToFile(File file, String content) {
    file.writeAsStringSync(content);
  }

  static Future<void> appendToFile(String path, String content) async {
    File file = File(path);
    if (!Utils.doesFileExist(path)) {
      Print.error("File doesnt Exist");
    }
    IOSink sink = file.openWrite(mode: FileMode.append);
    try {
      sink.writeln(content);
    } finally {
      await sink.flush();
      await sink.close();
    }
  }

  static insertContentInFile(String filePath, String codeBlock) {
    File file = File(filePath);
    final fileContent = file.readAsStringSync();
    final lastIndex = fileContent.lastIndexOf('}');
    if (lastIndex != -1) {
      final updatedContent = """${fileContent.substring(0, lastIndex)} 
          $codeBlock
          ${fileContent.substring(lastIndex)}""";
      file.writeAsStringSync(updatedContent);
      print('Function inserted successfully.');
    }
  }

  static insertConstructorFile(String filePath, String codeBlock) {
    File file = File(filePath);
    print(filePath);
    final fileContent = file.readAsStringSync();
    final regExp = RegExp(
        r'TestBloc\s*\(([^)]*)\)\s*:\s*super\(\s*TestInitialState\s*\(\s*\)\s*\)\s*\{([^}]*)\}');

    final match = regExp.firstMatch(fileContent);
    print(match);
    if (match != null) {
      final constructorBodyStart =
          match.start + match.group(0)!.indexOf('{') + 1;
      final constructorBodyEnd = match.end - 1;

      final updatedContent =
          """${fileContent.substring(0, constructorBodyStart)} 
           on<TestEvent>(_handleDefaultEvent);
          ${fileContent.substring(constructorBodyStart, constructorBodyEnd)}
          ${fileContent.substring(constructorBodyEnd)}
          """;
      file.writeAsStringSync(updatedContent);
      print('Function inserted successfully.');
    }
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
