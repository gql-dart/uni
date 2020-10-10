import "package:uni/src/tooling.dart";

abstract class Context {
  final String name;
  final String description;

  const Context({
    this.name,
    this.description,
  });

  Future<bool> isSupported();
}

class FlutterContext extends Context {
  const FlutterContext()
      : super(
          name: "flutter",
          description: "Flutter package.",
        );

  @override
  Future<bool> isSupported() => const FlutterTooling().isSupported();
}

class DartContext extends Context {
  const DartContext()
      : super(
          name: "dart",
          description: "Dart package.",
        );

  @override
  Future<bool> isSupported() => const AdaptiveTooling().isSupported();
}
