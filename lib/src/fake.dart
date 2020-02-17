import 'dart:convert';
import 'dart:io';

import 'core.dart';

Future<ResponseData> getSiteDataFake(File file) async {
  if (!(await file?.exists())) return null;

  final fileContentBuffer = await file.readAsString(encoding: Encoding.getByName('utf-8'));
  final json = jsonDecode(fileContentBuffer);

  return ResponseData(-1, -1, 200, json);
}
