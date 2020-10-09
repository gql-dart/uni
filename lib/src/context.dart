import "package:uni/src/tooling.dart";

abstract class Context {
  final String name;

  const Context({this.name});

  Future<bool> isSupported();
}

class FlutterContext extends Context {
  const FlutterContext() : super(name: "flutter");

  @override
  Future<bool> isSupported() => const FlutterTooling().isSupported();
}

class DartContext extends Context {
  const DartContext() : super(name: "dart");

  @override
  Future<bool> isSupported() => const AdaptiveTooling().isSupported();
}
