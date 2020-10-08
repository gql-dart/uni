import "dart:async";

import "package:pub_semver/src/version.dart";
import "package:uni/src/tool.dart";

class DartTool extends Tool {
  const DartTool() : super("dart");

  @override
  Future<Version> getVersion() async {
    final result = await run(["--version"]);
    final output = result.stderr.toString();
    final match = versionPattern.firstMatch(output);

    return Version.parse(match[0]);
  }
}
