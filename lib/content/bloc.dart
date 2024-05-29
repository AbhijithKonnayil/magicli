const BLOC_CONTENT = """
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part '{{eventFileName}}';
part '{{stateFileName}}';

class {{blocClassName}} extends Bloc<{{eventClassName}}, {{stateClassName}}> {
  {{blocClassName}}():super({{stateInitialClassName}}()){
    on<{{eventClassName}}>({{defaultEventHandler}});
  }

 {{defaultEventDefinition}}
}
""";

const EVENT_CONTENT = """
part of '{{blocFileName}}';

@immutable
sealed class {{eventClassName}} {}
final class {{defaultEventClassName}} extends {{eventClassName}} {}
""";

const STATE_CONTENT = """
part of '{{blocFileName}}';

@immutable
sealed class {{stateClassName}} {}

final class {{stateInitialClassName}} extends {{stateClassName}} {}
""";

const VIEW_CONTENT = """
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/{{blocFileName}}';

class {{viewClassName}} extends StatelessWidget {
  const {{viewClassName}}({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{blocClassName}}, {{stateClassName}}>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
""";
