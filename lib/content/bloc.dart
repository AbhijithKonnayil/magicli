const BLOC_CONTENT = """
import 'package:flutter_bloc/flutter_bloc.dart';
import '{{eventFileName}}';
import '{{stateFileName}}';

class {{blocClassName}} extends Bloc<{{eventClassName}}, {{stateClassName}}> {
  {{blocClassName}}();
}
""";

const EVENT_CONTENT = """
import 'package:equatable/equatable.dart';

abstract class {{eventClassName}} extends Equatable {}
""";

const STATE_CONTENT = """
import 'package:equatable/equatable.dart';

abstract class {{stateClassName}} extends Equatable {}
""";

const VIEW_CONTENT = """
import 'package:flutter_bloc/flutter_bloc.dart';
import '{{blocFileName}}';

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
