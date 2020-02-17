import 'dart:convert';
import 'dart:io';

import 'package:pinterest/pinterest.dart' as pinterest;

void main_createPinterestFilters(List<String> args) {
  if (args.isEmpty) return;

  final file = File(args.first);

  if (!file.existsSync()) {
    print('File does not exists');
    return;
  }

  final list = jsonDecode(file.readAsStringSync()) as List<dynamic>;

  final fieldValues = pinterest.FieldData.values;
  for (var obj in list) {
    obj = obj as Map<String, dynamic>;

    print(obj['category']);

    final map = obj['filters'] as Map<String, dynamic>;
    for (final key in map.keys) {
      final value = map[key] as List<dynamic>;

      if (value == null) {
        // print('  null');
        continue;
      }

      var filter = 0;
      for (var filterName in value) {
        filterName = filterName as String;

        for (var field in fieldValues) {
          if (filterName == field.name) {
            filter |= field.code;
            continue;
          }
        }
      }

      print('  $key: 0x${filter.toRadixString(16)}');
    }
  }
}

void main(List<String> args) async {
  if (args.isEmpty) return;

  pinterest.accessToken = 'AtOWyz84uNf-RzwXiHI6apV_fak1Fc4NtJ0yc6NGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA';
  pinterest.requestAllFields = true;

  // List<pinterest.BoardInfo> list;
  pinterest.ResponseData response;

  try {
    response = await pinterest.getSiteDataFake(File(args.first));

    // list = await pinterest.me.getMyBoards();
  } on dynamic catch(ex, stackTrace) {
    if (ex is pinterest.PinException) {
      print(ex.statusCode);
      print(ex.optionalMessage ?? 'Message is missing');
    } else {
      print(ex);
    }

    print(stackTrace);

    return;
  }

  final msg = pinterest.PinterestMessage<List<dynamic>>()..decode(response.json);

  final resultList = List<pinterest.BoardInfo>(msg.data.length);

  for (var i = 0; i < resultList.length; i++) {
    resultList[i] = pinterest.BoardInfo()..decode(msg.data[i]);
  }

  final buffer = StringBuffer();
  for (final boardInfo in resultList) {
    buffer.writeln(pinterest.log(boardInfo));
  }

  print(buffer);
}
