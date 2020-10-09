import "package:args/command_runner.dart";
import "package:uni/commands.dart";

void main(List<String> arguments) async {
  final runner = CommandRunner<void>(
    "uni",
    "Universal Dart/Flutter package manager.",
  );

  runner.argParser.addOption(
    "mode",
    abbr: "m",
    help: "Select tooling mode.",
    valueHelp: "MODE",
    defaultsTo: "adaptive",
    allowed: [
      "adaptive",
      "dart",
      "flutter",
      "legacy",
    ],
    allowedHelp: <String, String>{
      "adaptive": "Selects tooling based on package.",
      "dart": "Only use `dart` tool.",
      "flutter": "Only use `flutter` tool.",
      "legacy": "Only use legacy tooling.",
    },
  );

  runner.addCommand(DoctorCommand());

  await runner.run(arguments);
}
