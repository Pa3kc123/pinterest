import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';

import 'annotations.dart';

// System constants
const String NEWLINE = '\n';
const String TAB = '  ';

// Dart keywords
const String STATIC = 'static';
const String FINAL = 'final';
const String CLASS = 'class';
const String GET = 'get';
const String SET = 'set';
const String OVERRIDE = '@override';

// DartObject#getField() constants
const DART_OBJECT_SUPER = '(super)';

// JsonData
const String JSON_DATA_TYPE = 'type';   // final String type;

// JsonProperty
const String JSON_PROPERTY_KEY = 'key';               // final String key;
const String JSON_PROPERTY_CONVERTION_TYPE = 'type';  // final _ConvertionType type;

// ParseableJsonProperty : JsonProperty
const String PARSEABLE_JSON_PROPERTY_BASE_TYPE = 'baseType';
const String PARSEABLE_JSON_PROPERTY_PARSE_FUNC = 'parseFunc';

DartObject getAnnotation<T>(Element element) {
  var annotations = TypeChecker.fromRuntime(T).annotationsOf(element);

  for (var ann in annotations) {
    if (ann.hasKnownValue) {
      return ann;
    }
  }

  return null;
}

class JsonPropertyGenerator extends Generator {
  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final lines = <String>[];

    lines.add(generateImports().join());

    for (var cls in library.allElements.whereType<ClassElement>().where((element) => !element.isEnum)) {
      var annotation = getAnnotation<JsonData>(cls);

      if (annotation == null) continue;

      var type = annotation.getField('type').toStringValue();

      _ClassGenerator(cls).toString();

      var fieldNames = <String>[];

      for (var field in cls.fields) {
        fieldNames.add(field.name);
      }

      lines.addAll([
        generateClassHead(cls, type),
        generateFields(cls.fields).join(NEWLINE),
        generateConstructor(cls.name, fieldNames).join(NEWLINE),
        generateGetters(cls.fields).join(NEWLINE),
        generateDecodeAction(type, cls.fields).join(NEWLINE),
        generateEncodeAction(type, fieldNames).join(NEWLINE),
        '}$NEWLINE'
      ]);
    }

    return lines.join(NEWLINE);
  }

  List<String> generateImports() => const <String>[
    "import 'util.dart';",
    NEWLINE
  ];

  String generateClassHead(ClassElement cls, [String jsonDataClsName]) {
    if (cls == null) return '#ERROR#generateClassHead#';

    final buffer = StringBuffer('class ${cls.thisType}');

    if (jsonDataClsName?.isNotEmpty ?? false) {
      buffer.write(' extends AJsonData<$jsonDataClsName>');
    }

    buffer.write(' {');

    return buffer.toString();
  }

  List<String> generateFields(List<FieldElement> fields) {
    if (fields?.isEmpty ?? true) return const <String>['#ERROR#generateFields#'];

    final lines = <String>[];

    for (var field in fields) {
      if (getAnnotation<JsonProperty>(field) == null) {
        lines.add('$TAB${field.type} ${field.name}');
      } else {
        lines.add('${TAB}JsonProperty<${field.type}> ${field.name};');
      }

      if (field.isStatic && field.isFinal) {

      } else {
      }
    }

    return lines..add('');
  }

  List<String> generateConstructor(String className, List<String> fieldNames) {
    if (className?.isEmpty ?? true) return const <String>['#ERRROR#generateConstructor#'];
    if (fieldNames.isEmpty) return <String>['$TAB$className();'];

    final lines = <String>[];

    lines.add('$TAB$className([');

    for (var i = 0; i < fieldNames.length; i++) {
      var fieldName = fieldNames[i];
      lines.add('$TAB${TAB}this.$fieldName${i != fieldNames.length - 1 ? "," : ""}');
    }

    lines.add('$TAB]);');

    return lines..add('');
  }

  List<String> generateGetters(List<FieldElement> fields) {
    if (fields?.isEmpty ?? true) return const <String>['#ERROR#generateGetters#'];

    final lines = <String>[];

    for (var field in fields) {
      var getterName = field.name;

      if (field.isPrivate) {
        getterName = getterName.substring(1, getterName.length);
      }

      lines.add('$TAB${field.type} $GET $getterName => ${field.name}?.value;');
    }

    return lines..add('');
  }

  List<String> generateDecodeAction(String type, List<FieldElement> fields) {
    if ((type?.isEmpty ?? true)) {
      return const <String>['#ERROR#generateDecodeAction#'];
    }

    var lines = <String>[];

    if (fields?.isEmpty ?? true) {
      lines.add('void decode($type json) => null;');
      return lines;
    }

    lines.add('$TAB$OVERRIDE');
    lines.add('${TAB}void decode($type json) {');
    lines.add('$TAB${TAB}if (json == null) return;$NEWLINE');
    lines.add('$TAB${TAB}final decoder = JsonDecoder(json);$NEWLINE');

    for (var field in fields) {
      final annotation = getAnnotation<JsonProperty>(field);

      if (annotation == null) continue;

      final superClass = annotation.getField(DART_OBJECT_SUPER);
      final jsonKey = superClass.getField(JSON_PROPERTY_KEY).toStringValue();
      final convertType = superClass.getField(JSON_PROPERTY_CONVERTION_TYPE).toIntValue();

      switch (convertType) {
        case PARSE:
          final baseType = annotation.getField(PARSEABLE_JSON_PROPERTY_BASE_TYPE).toStringValue();
          final parseFunc = annotation.getField(PARSEABLE_JSON_PROPERTY_PARSE_FUNC).toStringValue();
          lines.add("$TAB$TAB${field.name} = decoder.getAndParse<$baseType, ${field.type}>('$jsonKey', (value) => $parseFunc);");
        break;

        case CAST:
        default:
          lines.add("$TAB$TAB${field.name} = decoder.getAndCast<${field.type}>('$jsonKey');");
        break;
      }
    }

    lines.add('$TAB}');

    return lines..add('');
  }

  List<String> generateEncodeAction(String type, List<String> fieldNames) {
    if (type?.isEmpty == null) {
      return const <String>['#ERROR#generateEncodeAction#'];
    }

    var lines = <String>[
      '$TAB$OVERRIDE'
    ];

    if (fieldNames?.isEmpty ?? true) {
      lines.add('$TAB$type encode() => null;');
    }

    lines.add('${TAB}Map<String, dynamic> encode() => encodeValues(${fieldNames.toString()});');

    return lines;
  }
}

class _ClassGenerator {
  ClassElement _cls;
  List<FieldElement> _fields;
  DartObject _annotation;
  bool _hasAnnotation;

  _ClassGenerator(this._cls, [this._fields]) {
    _annotation = getAnnotation<JsonData>(cls);
    _hasAnnotation = (annotation != null);
  }

  ClassElement get cls => _cls;
  List<FieldElement> get fields => _fields;
  DartObject get annotation => _annotation;
  bool get hasAnnotation => _hasAnnotation;

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.write('class ${cls.thisType} ');
    if (hasAnnotation) buffer.write('extends AJsonData<${annotation.getField(JSON_DATA_TYPE)}> ');
    buffer.writeln('{');

    for (var field in fields) {
      if (getAnnotation<JsonProperty>(field) == null) {
        if (field.isStatic && field.isFinal) {
          buffer.writeln('$STATIC $FINAL ${field.type} ${field.name} = ${field.initializer}');
        }
      } else {
      }
    }
  }
}
