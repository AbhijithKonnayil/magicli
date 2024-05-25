import 'package:args/command_runner.dart';
import 'package:magicli/command/add_command.dart';

void runCommand(arguments) {
  CommandRunner('magicli', 'description')
    ..addCommand(AddCommand())
    ..run(arguments);
}
