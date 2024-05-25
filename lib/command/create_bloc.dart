import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:magicli/command/add_state.dart';
import 'package:magicli/content/bloc.dart';
import 'package:magicli/extensions/string.dart';
import 'package:magicli/utils/color_print.dart';
import 'package:magicli/utils/utils.dart';
import 'package:path/path.dart' as path;

class AddFeatureCommand extends Command {
  AddFeatureCommand() {
    argParser
      ..addOption('name', abbr: 'n', help: 'Name of the Feature')
      ..addOption('directory',
          abbr: 'd', help: 'Directory to create the BLoC in');
  }

  @override
  String get description => 'create feature';

  @override
  String get name => 'feature';

  @override
  Future<void> run() async {
    if (await Utils.isDartProjectRoot()) {
      createFeature();
    }
  }

  Future<void> createFeature() async {
    print("create feature");
    String name = argResults?["name"];
    Directory? libDir = await Utils.getLibDir();
    Directory blocDirectory = Directory("${libDir!.path}/$name");
    blocDirectory.createSync();
    generateBloc(name, blocDirectory);
  }

  void generateBloc(String blocName, Directory directory) {
    if (!directory.existsSync()) {
      directory.createSync();
    }
    Directory blocDir = Directory(path.join(directory.path, "bloc"))
      ..createSync();
    final snakeCaseBlocName = blocName.replaceAll(' ', '').toLowerCase();
    final blocProperCase = snakeCaseBlocName.toProperCase();
    //class names
    final blocClassName = '${blocProperCase}Bloc';
    final stateClassName = '${blocProperCase}State';
    final eventClassName = '${blocProperCase}Event';
    final viewClassName = '${blocProperCase}View';
    //file names
    final blocFileName = '${snakeCaseBlocName}_bloc.dart';
    final eventFileName = '${snakeCaseBlocName}_event.dart';
    final stateFileName = '${snakeCaseBlocName}_state.dart';
    final viewFileName = '${snakeCaseBlocName}_view.dart';

    final blocFile = Utils.createFile(blocDir, blocFileName);
    final eventFile = Utils.createFile(blocDir, eventFileName);
    final stateFile = Utils.createFile(blocDir, stateFileName);
    final viewFile = Utils.createFile(directory, viewFileName);
    final templateKeyValues = {
      "eventFileName": eventFileName,
      "stateFileName": stateFileName,
      'blocFileName': blocFileName,
      "blocClassName": blocClassName,
      "eventClassName": eventClassName,
      "stateClassName": stateClassName,
      "viewClassName": viewClassName,
    };
    blocFile.writeAsStringSync(updateTemplate(BLOC_CONTENT, templateKeyValues));
    eventFile
        .writeAsStringSync(updateTemplate(EVENT_CONTENT, templateKeyValues));
    stateFile
        .writeAsStringSync(updateTemplate(STATE_CONTENT, templateKeyValues));
    viewFile.writeAsStringSync(updateTemplate(VIEW_CONTENT, templateKeyValues));
    Print.success('BLoC files generated successfully in $directory');
  }
}

class AddBlocCommand extends Command {
  AddBlocCommand() {
    argParser
      ..addOption('name', abbr: 'n', help: 'Name of the BLoC')
      ..addOption('directory',
          abbr: 'd', help: 'Directory to create the BLoC in');
  }

  @override
  String get description => 'create bloc';

  @override
  String get name => 'bloc';

  void run() {
    Utils.isDartProjectRoot();
  }
}
