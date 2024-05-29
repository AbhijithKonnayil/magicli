import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:magicli/utils/bloc_nameing_utils.dart';
import 'package:magicli/utils/utils.dart';

class AddEventCommand extends Command {
  AddEventCommand() {
    argParser
      ..addOption('name', abbr: 'n', help: 'Name of the Event')
      ..addOption('bloc', abbr: 'b', help: 'Directory to create the BLoC in');
  }

  @override
  String get description => 'create event';

  @override
  String get name => 'event';

  @override
  Future<void> run() async {
    String name = argResults?["name"];
    String bloc = argResults?["bloc"];
    String pwd = await Utils.getPwd();
    String blocPath = "$pwd/del/$bloc";
    if (Utils.doesFolderExist(blocPath)) {
      print("exist");
      String eventFilePath = "$blocPath/bloc/${bloc}_event.dart";
      String code = BlocNaming(bloc).getEventClassDefinition(name);
      await Utils.appendToFile(eventFilePath, code);

      ///
      String blocFilePath = "$blocPath/bloc/${bloc}_bloc.dart";
      //Utils.insertContentInFile(blocFilePath, "codeBlock 1");
      Utils.insertConstructorFile(blocFilePath, "codeBlock 2");
      return;

      //List<String> lines = await File(blocFilePath).readAsLines();
      final content = File(blocFilePath).readAsStringSync();
      final lastIndex = content.lastIndexOf('}');

      if (lastIndex != -1) {
        // Insert the new function before the last closing brace
        final updatedContent = content.substring(0, lastIndex) +
            '\n\n' +
            "newFunction" +
            '\n' +
            content.substring(lastIndex);

        // Write the updated content back to the file
        File(blocFilePath).writeAsStringSync(updatedContent);
        print('Function inserted successfully.');
      } else {
        print('Closing brace not found.');
      }
    }
  }
}
