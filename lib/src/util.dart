abstract class IEncodable {
  Map<String, dynamic> encode();
}

abstract class IDecodable {
  void decode(Map<String, dynamic> json);
}

abstract class IJsonData implements IEncodable, IDecodable {}

class JsonProperty<T> {
  final String name;
  final T value;

  const JsonProperty(this.name, this.value);
}

class PinException implements Exception {
  final int errorCode;
  final int limit;
  final int remains;

  const PinException(this.errorCode, this.limit, this.remains);
}

class JsonDecoder {
  final Map<String, dynamic> json;

  const JsonDecoder(this.json);

  JsonProperty<T> get<T>(String name) => JsonProperty<T>(name, json[name] as T);

  JsonProperty<E> getAndCast<T, E>(String name, [E Function(T value) parser]) {
    final property = get<T>(name);

    return JsonProperty(property.name, parser == null ? property.value as E : parser(property.value));
  }
}

int tabs = 0;
String log(Encodable<dynamic> parser) {
  final buffer = StringBuffer();

  final map = parser.encode();

  buffer.writeln('{');
  tabs++;

  String tab;
  for (var key in map.keys) {
    tab = '';

    for (var i = tabs * 2; i >= 1; i--) {
      tab += ' ';
    }

    buffer.writeln('$tab$key = ${map[key].toString()}');
  }

  tabs--;
  buffer.write('${tab.replaceRange(0, 2, "")}}');

  return buffer.toString();
}

Map<String, dynamic> encodeValues(List<JsonProperty<dynamic>> values) {
  const map = <String, dynamic>{};

  for (var value in values) {
    map[value.name] = value.value;
  }

  return map;
}
