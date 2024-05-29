import 'package:magicli/extensions/string.dart';

class BlocNaming {
  late final String baseName;
  BlocNaming(String baseName) {
    this.baseName = baseName.toProperCase();
  }
  String get baseNameLowerCase => baseName.toLowerCase();

  //File Names
  String get blocFileName => '${baseNameLowerCase}_bloc.dart';
  String get eventFileName => '${baseNameLowerCase}_event.dart';
  String get stateFileName => '${baseNameLowerCase}_state.dart';
  String get viewFileName => '${baseNameLowerCase}_view.dart';

  //classNames

  String get blocClassName => '${baseName}Bloc';
  String get baseStateClassName => getStateClassName(baseName);
  String get baseEventClassName => getEventClassName(baseName);
  String get viewClassName => '${baseName}View';
  String get stateInitialClassName => getStateClassName("${baseName}Initial");
  String get defaultEventClassName => getEventClassName("${baseName}Default");

  String getStateClassName(String name) => "${name.toProperCase()}State";
  String getEventClassName(String name) => "${name.toProperCase()}Event";

  String getStateClassDefinition(String stateBaseName) {
    String stateClass = getStateClassName(stateBaseName);
    return "class $stateClass extends $baseStateClassName{}";
  }

  String getEventClassDefinition(String eventBaseName) {
    String eventClass = getEventClassName(eventBaseName);
    return "class $eventClass extends $baseEventClassName{}";
  }

  String getEventHandlerNameFromEvent(String eventBaseName) {
    return '_handle${eventBaseName.toProperCase()}Event';
  }

  String getEventHandlerDefinition(String eventBasename) {
    String handlerName = getEventHandlerNameFromEvent(eventBasename);

    return 'void $handlerName($baseEventClassName event, Emitter<$baseStateClassName> emitter) {}';
  }
}
