import "dart:async";
import "dart:io" as io;

import "package:args/command_runner.dart";
import "package:uni/src/tool.dart";
import "package:uni/src/tools/dart_tool.dart";
import "package:uni/src/tools/dartanalyzer_tool.dart";
import "package:uni/src/tools/dartdoc_tool.dart";
import "package:uni/src/tools/dartfmt_tool.dart";
import "package:uni/src/tools/flutter_tool.dart";
import "package:uni/src/tools/pub_tool.dart";

class DoctorCommand extends Command<void> {
  @override
  final String name = "doctor";

  @override
  final String description = "Show information about the installed tooling.";

  DoctorCommand();

  @override
  FutureOr<void> run() async {
    final tools = <Tool>[
      FlutterTool(),
      DartTool(),
      PubTool(),
      DartAnalyzerTool(),
      DartFmtTool(),
      DartDocTool(),
    ];

    for (final tool in tools) {
      if (!tool.isAvailable()) {
        print(":( --> ${tool.name}");
        continue;
      }
      print(":) --> ${tool.name}");
      await tool.run(
        ["--version"],
        stdout: io.stdout,
        stderr: io.stderr,
      );
    }
  }
}
