import "dart:async";

import "package:args/command_runner.dart";
import "package:ansi_styles/ansi_styles.dart";

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
    ansiStylesDisabled = false;

    print("Available tools:");
    for (final tool in tools) {
      if (!tool.isAvailable()) {
        print("${AnsiStyles.red("[!]")} ${AnsiStyles.bold(tool.name)}");
        continue;
      }
      print(
          "${AnsiStyles.green("[✓]")} ${AnsiStyles.bold(tool.name)}, version: ${await tool.getVersion()}");
    }

    print("");

    print("Supported tooling: ");
    for (final tooling in toolingSet) {
      if (!await tooling.isSupported()) {
        print(
            "${AnsiStyles.red("[!]")} ${AnsiStyles.bold(tooling.name)}: ${tooling.description}");
        continue;
      }
      print(
          "${AnsiStyles.green("[✓]")} ${AnsiStyles.bold(tooling.name)}: ${tooling.description}");
    }

    print("");

    print("Supported contexts: ");
    for (final context in contexts) {
      if (!await context.isSupported()) {
        print(
            "${AnsiStyles.red("[!]")} ${AnsiStyles.bold(context.name)}: ${context.description}");
        continue;
      }
      print(
          "${AnsiStyles.green("[✓]")} ${AnsiStyles.bold(context.name)}: ${context.description}");
    }
  }
}
