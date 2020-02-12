abstract class IEncodable<T> {
  T encode();
}

abstract class IDecodable<T> {
  void decode(T json);
}

abstract class AJsonData<T> implements IEncodable<T>, IDecodable<T> {
  const AJsonData();

  @override
  String toString() => encode().toString();
}

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

  JsonProperty<T> getAndCast<T>(String name) => JsonProperty<T>(name, json[name] as T);

  JsonProperty<E> getAndParse<T, E>(String name, E Function(T value) parser) {
    final property = getAndCast<T>(name);

    return JsonProperty(property.name, parser?.call(property.value) ?? property.value as E);
  }
}

int tabs = 0;
String log(IEncodable parser) {
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
