import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'tools/generators.dart';

Builder jsonProperty(BuilderOptions options) => LibraryBuilder(
  JsonPropertyGenerator(),
  formatOutput: (code) => code
);
