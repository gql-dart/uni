import "package:args/command_runner.dart";
import "package:uni/commands.dart";
import "package:uni/src/tooling.dart";

void main(List<String> arguments) async {
  final runner = CommandRunner<void>(
    "uni",
    "Universal Dart/Flutter package manager.",
  );

  runner.argParser.addOption(
    "tooling",
    abbr: "t",
    help: "Select tooling.",
    valueHelp: "TOOLING",
    defaultsTo: const AdaptiveTooling().name,
    allowed: [
      const AdaptiveTooling().name,
      const DartTooling().name,
      const FlutterTooling().name,
      const LegacyTooling().name,
    ],
    allowedHelp: <String, String>{
      const AdaptiveTooling().name: const AdaptiveTooling().description,
      const DartTooling().name: const DartTooling().description,
      const FlutterTooling().name: const FlutterTooling().description,
      const LegacyTooling().name: const LegacyTooling().description,
    },
  );

  runner.addCommand(DoctorCommand());

  await runner.run(arguments);
}
