import 'package:args/command_runner.dart';
import 'package:magicli/command/add_state.dart';
import 'package:magicli/command/create_bloc.dart';

class AddCommand extends Command {
  AddCommand() {
    addSubcommand(AddFeatureCommand());
    addSubcommand(AddStateCommand());
  }

  @override
  String get description => 'add';

  @override
  String get name => 'add';
}
