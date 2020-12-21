import "package:uni/src/tool.dart";
import "package:uni/src/tools/dart_tool.dart";
import "package:uni/src/tools/dartanalyzer_tool.dart";
import "package:uni/src/tools/dartfmt_tool.dart";
import "package:uni/src/tools/flutter_tool.dart";
import "package:uni/src/tools/pub_tool.dart";

abstract class UniCommand {
  final String name;
  final String description;

  const UniCommand({
    this.name,
    this.description,
  });

  List<String> getArgsFor(Tool tool);
}

class PubCommand extends UniCommand {
  const PubCommand()
      : super(
          name: "pub",
          description: "Work with packages.",
        );

  @override
  List<String> getArgsFor(Tool tool) {
    if (tool is DartTool || tool is FlutterTool) {
      return ["pub"];
    }

    if (tool is PubTool) {
      return [];
    }

    return null;
  }
}

class AnalyzeCommand extends UniCommand {
  const AnalyzeCommand()
      : super(
          name: "analyze",
          description: "Analyze the project's Dart code.",
        );

  @override
  List<String> getArgsFor(Tool tool) {
    if (tool is DartTool || tool is FlutterTool) {
      return ["analyze"];
    }

    if (tool is DartAnalyzerTool) {
      return [];
    }

    return null;
  }
}

class FormatCommand extends UniCommand {
  const FormatCommand()
      : super(
          name: "format",
          description: "Idiomatically format Dart source code.",
        );

  @override
  List<String> getArgsFor(Tool tool) {
    if (tool is DartTool || tool is FlutterTool) {
      return ["format"];
    }

    if (tool is DartFmtTool) {
      return [];
    }

    return null;
  }
}

class TestCommand extends UniCommand {
  const TestCommand()
      : super(
          name: "test",
          description: "Run all the tests.",
        );

  @override
  List<String> getArgsFor(Tool tool) {
    if (tool is DartTool || tool is FlutterTool) {
      return ["test"];
    }

    return null;
  }
}
