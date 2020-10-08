import "dart:async";
import "dart:convert";
import "dart:io";

import "package:process_run/process_run.dart" as process_run;
import "package:process_run/which.dart";
import "package:pub_semver/pub_semver.dart";

abstract class Tool {
  final String name;

  const Tool(this.name);

  String getLocation() => whichSync(name);

  bool isAvailable() => getLocation() != null;

  Future<Version> getVersion() async {
    final result = await run(["--version"]);
    final output = result.stdout.toString();
    final match = versionPattern.firstMatch(output);

    return Version.parse(match[0]);
  }

  Future<ProcessResult> run(
    List<String> arguments, {
    String workingDirectory,
    Map<String, String> environment,
    bool includeParentEnvironment = true,
    bool runInShell,
    Encoding stdoutEncoding = systemEncoding,
    Encoding stderrEncoding = systemEncoding,
    Stream<List<int>> stdin,
    StreamSink<List<int>> stdout,
    StreamSink<List<int>> stderr,
  }) =>
      process_run.run(
        name,
        arguments,
        workingDirectory: workingDirectory,
        environment: environment,
        includeParentEnvironment: includeParentEnvironment,
        runInShell: runInShell,
        stderr: stderr,
        stderrEncoding: stderrEncoding,
        stdin: stdin,
        stdout: stdout,
        stdoutEncoding: stdoutEncoding,
      );
}

final versionPattern = RegExp(
  r"(\d+).(\d+).(\d+)" // Version number.
  r"(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?" // Pre-release.
  r"(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?", // Build.
);
