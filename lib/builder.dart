import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:pinterest/src/json_property_generator.dart';

Builder jsonProperty(BuilderOptions options) => SharedPartBuilder([JsonPropertyGenerator()], 'a_json_property');
