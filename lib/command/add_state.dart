import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:magicli/extensions/string.dart';
import 'package:magicli/utils/utils.dart';

class AddStateCommand extends Command {
  AddStateCommand() {
    argParser
      ..addOption('name', abbr: 'n', help: 'Name of the State')
      ..addOption('bloc', abbr: 'b', help: 'Directory to create the BLoC in');
  }

  @override
  String get description => 'create state';

  @override
  String get name => 'state';

  @override
  Future<void> run() async {
    String name = argResults?["name"];
    String bloc = argResults?["bloc"];
    String pwd = await Utils.getPwd();
    String blocPath = "$pwd/del/$bloc";
    if (Utils.doesFolderExist(blocPath)) {
      print("exist");
      File stateFile = File("$blocPath/bloc/${bloc}_state.dart");
      if (stateFile.existsSync()) {
        IOSink sink = stateFile.openWrite(mode: FileMode.append);
        try {
          String code =
              "class ${name.toProperCase()}State extends ${bloc.toProperCase()}State{}";
          sink.writeln(code);
        } finally {
          await sink.flush();
          await sink.close();
        }
        return;
        List<String> lines = await stateFile.readAsLines();
        List<String> processedLines = [];
        for (String line in lines) {
          // Apply your condition here. For example, only keep lines that are not empty
          if (line.isNotEmpty) {
            processedLines.add(line);
            print(line);
          }
        }
        stateFile.writeAsStringSync(processedLines.join('\n'));
      } else {
        print("File dont exist");
      }
    }
  }
}
