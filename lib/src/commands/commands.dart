import "dart:io";

import "package:args/args.dart";
import "package:args/command_runner.dart";
import "package:path/path.dart" as path;
import "package:pubspec/pubspec.dart";
import "package:uni/src/context.dart";
import "package:uni/src/tooling.dart";
import "package:uni/src/uni_commands.dart" as uni;

Future<Context> getContext(Directory dir) async {
  if (dir.path == dir.parent.path) {
    return DartContext();
  }

  final pubspecPath = path.join(dir.path, "pubspec.yaml");

  if (await File(pubspecPath).exists()) {
    final pubspec = await PubSpec.loadFile(pubspecPath);

    return pubspec.allDependencies.containsKey("flutter")
        ? FlutterContext()
        : DartContext();
  }

  return getContext(dir.parent);
}

abstract class PassthroughCommand extends Command<void> {
  final uni.UniCommand uniCommand;

  @override
  String get name => uniCommand.name;

  @override
  String get description => uniCommand.description;

  @override
  ArgParser argParser = ArgParser.allowAnything();

  PassthroughCommand(this.uniCommand);

  @override
  Future<void> run() async {
    final context = await getContext(Directory.current);

    final tooling = Tooling.fromName(
      globalResults["tooling"] as String,
    );

    final conf = await tooling.getToolFor(
      uniCommand,
      context,
    );

    final result = await conf.tool.run(
      [
        ...conf.args,
        ...argResults.arguments,
      ],
      stdout: stdout,
      stderr: stderr,
    );

    exit(result.exitCode);
  }
}

class PubCommand extends PassthroughCommand {
  PubCommand() : super(const uni.PubCommand());
}

class AnalyzeCommand extends PassthroughCommand {
  AnalyzeCommand() : super(const uni.AnalyzeCommand());
}

class FormatCommand extends PassthroughCommand {
  FormatCommand() : super(const uni.FormatCommand());
}
