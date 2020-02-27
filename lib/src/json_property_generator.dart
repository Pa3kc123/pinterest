import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

class JsonPropertyGenerator extends GeneratorForAnnotation<AJsonProperty> {
  const JsonPropertyGenerator();

  @override
  AJsonProperty generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element == null || annotation == null || buildStep == null) return null;

    return null;
  }
}

class AJsonProperty {
  final String name;

  const AJsonProperty(this.name) : assert(name != null);
}
