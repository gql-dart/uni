import "package:args/command_runner.dart";
import "package:uni/commands.dart";

void main(List<String> arguments) async {
  final runner = CommandRunner<void>(
    "uni",
    "Universal Dart/Flutter package manager.",
  );

  runner.addCommand(DoctorCommand());

  await runner.run(arguments);
}
