import "package:pub_semver/pub_semver.dart";
import "package:uni/src/tools/dart_tool.dart";
import "package:uni/src/tools/dartanalyzer_tool.dart";
import "package:uni/src/tools/dartdoc_tool.dart";
import "package:uni/src/tools/dartfmt_tool.dart";
import "package:uni/src/tools/flutter_tool.dart";
import "package:uni/src/tools/pub_tool.dart";

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
}

class FlutterTooling extends Tooling {
  const FlutterTooling()
      : super(
          name: "flutter",
          description: "Only use `flutter` tool.",
        );

  @override
  Future<bool> isSupported() async => const FlutterTool().isAvailable();
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
}
