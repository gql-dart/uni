import "package:args/args.dart";
import "package:args/command_runner.dart";

abstract class PassthroughCommand extends Command<void> {
  @override
  final String name;

  @override
  final String description;

  @override
  ArgParser argParser = ArgParser.allowAnything();

  PassthroughCommand({
    this.name,
    this.description,
  });
}

class PubCommand extends PassthroughCommand {
  PubCommand()
      : super(
          name: "pub",
          description: "Work with packages.",
        );
}

class AnalyzeCommand extends PassthroughCommand {
  AnalyzeCommand()
      : super(
          name: "analyze",
          description: "Analyze the project's Dart code.",
        );
}

class FormatCommand extends PassthroughCommand {
  FormatCommand()
      : super(
          name: "format",
          description: "Idiomatically format Dart source code.",
        );
}
