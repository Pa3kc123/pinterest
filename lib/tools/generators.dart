library pinterest.builder;

import 'dart:html';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import '../tools/annotations.dart';

class JsonPropertyGenerator extends GeneratorForAnnotation<JsonData> {
  @override
  JsonData generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      for (var field in element.fields) {
        if (field?.getter == null) {

        }
      }
    }

    if (element is FieldElement) {

    }

    return null;
  }
}
