import "dart:async";

import "package:args/command_runner.dart";
import "package:uni/src/context.dart";
import "package:uni/src/tooling.dart";
import "package:uni/src/tools/dart_tool.dart";
import "package:uni/src/tools/dartanalyzer_tool.dart";
import "package:uni/src/tools/dartdoc_tool.dart";
import "package:uni/src/tools/dartfmt_tool.dart";
import "package:uni/src/tools/flutter_tool.dart";
import "package:uni/src/tools/pub_tool.dart";

const tools = [
  FlutterTool(),
  DartTool(),
  PubTool(),
  DartAnalyzerTool(),
  DartFmtTool(),
  DartDocTool(),
];

const contexts = [
  FlutterContext(),
  DartContext(),
];

const toolingSet = [
  AdaptiveTooling(),
  DartTooling(),
  FlutterTooling(),
  LegacyTooling(),
];

class DoctorCommand extends Command<void> {
  @override
  final String name = "doctor";

  @override
  final String description = "Show information about the installed tooling.";

  DoctorCommand();

  @override
  FutureOr<void> run() async {
    print("Available tools:");
    for (final tool in tools) {
      if (!tool.isAvailable()) {
        print("[X] ${tool.name}");
        continue;
      }
      print("[√] ${tool.name}, version: ${await tool.getVersion()}");
    }

    print("");

    print("Supported contexts: ");
    for (final context in contexts) {
      if (!await context.isSupported()) {
        print("[X] ${context.name}");
        continue;
      }
      print("[√] ${context.name}");
    }

    print("");

    print("Supported tooling: ");
    for (final tooling in toolingSet) {
      if (!await tooling.isSupported()) {
        print("[X] ${tooling.name}");
        continue;
      }
      print("[√] ${tooling.name}");
    }
  }
}
