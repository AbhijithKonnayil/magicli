import 'package:args/command_runner.dart';

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
  }
}
