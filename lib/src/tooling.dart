import "package:pub_semver/pub_semver.dart";
import "package:uni/src/context.dart";
import "package:uni/src/tool.dart";
import "package:uni/src/tools/dart_tool.dart";
import "package:uni/src/tools/dartanalyzer_tool.dart";
import "package:uni/src/tools/dartdoc_tool.dart";
import "package:uni/src/tools/dartfmt_tool.dart";
import "package:uni/src/tools/flutter_tool.dart";
import "package:uni/src/tools/pub_tool.dart";
import "package:uni/src/uni_commands.dart";

class ToolConfig {
  final Tool tool;
  final List<String> args;

  const ToolConfig({
    this.tool,
    this.args,
  });
}

abstract class Tooling {
  final String name;
  final String description;

  const Tooling({
    this.name,
    this.description,
  });

  factory Tooling.fromName(String name) {
    if (const AdaptiveTooling().name == name) {
      return const AdaptiveTooling();
    }

    if (const DartTooling().name == name) {
      return const DartTooling();
    }

    if (const FlutterTooling().name == name) {
      return const FlutterTooling();
    }

    if (const LegacyTooling().name == name) {
      return const LegacyTooling();
    }

    return null;
  }

  Future<bool> isSupported();

  Future<ToolConfig> getToolFor(
    UniCommand command,
    Context context,
  );
}

class AdaptiveTooling extends Tooling {
  const AdaptiveTooling()
      : super(
          name: "adaptive",
          description: "Use whatever tooling is available.",
        );

  @override
  Future<bool> isSupported() async => Stream.fromFutures([
        const DartTooling().isSupported(),
        const FlutterTooling().isSupported(),
        const LegacyTooling().isSupported(),
      ]).any(
        (supported) => supported,
      );

  @override
  Future<ToolConfig> getToolFor(
    UniCommand command,
    Context context,
  ) async {
    if (context is FlutterContext) {
      if (await const FlutterTooling().isSupported()) {
        return const FlutterTooling().getToolFor(
          command,
          context,
        );
      }

      return null;
    }

    if (context is DartContext) {
      if (await const DartTooling().isSupported()) {
        return const DartTooling().getToolFor(
          command,
          context,
        );
      }

      if (await const LegacyTooling().isSupported()) {
        return const LegacyTooling().getToolFor(
          command,
          context,
        );
      }

      if (await const FlutterTooling().isSupported()) {
        return const FlutterTooling().getToolFor(
          command,
          context,
        );
      }

      return null;
    }

    return null;
  }
}

class DartTooling extends Tooling {
  const DartTooling()
      : super(
          name: "dart",
          description: "Only use `dart` tool. Requires version ^2.10.0.",
        );

  @override
  Future<bool> isSupported() async =>
      const DartTool().isAvailable() &&
      VersionConstraint.parse("^2.10.0").allows(
        await const DartTool().getVersion(),
      );

  @override
  Future<ToolConfig> getToolFor(
    UniCommand command,
    Context context,
  ) async {
    if (context is DartContext) {
      const dartTool = DartTool();

      return ToolConfig(
        tool: dartTool,
        args: command.getArgsFor(dartTool),
      );
    }

    return null;
  }
}

class FlutterTooling extends Tooling {
  const FlutterTooling()
      : super(
          name: "flutter",
          description: "Only use `flutter` tool.",
        );

  @override
  Future<bool> isSupported() async => const FlutterTool().isAvailable();

  @override
  Future<ToolConfig> getToolFor(
    UniCommand command,
    Context context,
  ) async {
    const flutterTool = FlutterTool();

    return ToolConfig(
      tool: flutterTool,
      args: command.getArgsFor(flutterTool),
    );
  }
}

class LegacyTooling extends Tooling {
  const LegacyTooling()
      : super(
          name: "legacy",
          description: "Only use legacy tooling.",
        );

  @override
  Future<bool> isSupported() async => const [
        PubTool(),
        DartAnalyzerTool(),
        DartFmtTool(),
        DartDocTool(),
      ].every(
        (tool) => tool.isAvailable(),
      );

  @override
  Future<ToolConfig> getToolFor(
    UniCommand command,
    Context context,
  ) async {
    if (context is DartContext) {
      if (command is PubCommand) {
        const pubTool = PubTool();

        return ToolConfig(
          tool: pubTool,
          args: command.getArgsFor(pubTool),
        );
      }

      if (command is FormatCommand) {
        const dartFmtTool = DartFmtTool();

        return ToolConfig(
          tool: dartFmtTool,
          args: command.getArgsFor(dartFmtTool),
        );
      }

      if (command is AnalyzeCommand) {
        const dartAnalyzerTool = DartAnalyzerTool();

        return ToolConfig(
          tool: dartAnalyzerTool,
          args: command.getArgsFor(dartAnalyzerTool),
        );
      }
    }

    return null;
  }
}
