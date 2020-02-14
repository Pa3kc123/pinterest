import 'core.dart';

abstract class IEncodable {
  Map<String, dynamic> encode();
}

abstract class IDecodable<T> {
  void decode(T json);
}

abstract class AJsonData<T> implements IEncodable, IDecodable<T> {
  const AJsonData();

  @override
  String toString() => log(this);
}

class JsonProperty<T> {
  final String name;
  final T value;

  const JsonProperty(this.name, this.value);

  @override
  String toString() => '"$name":"$value" (${value.runtimeType})';
}

class PinException implements Exception {
  final ResponseData _data;
  final String _message;

  const PinException(this._data, [this._message]);

  int get rateLimit => _data?.rateLimit;
  int get rateRemaining => _data?.rateRemaining;
  int get statusCode => _data?.statusCode;
  Map<String, dynamic> get json => _data?.json;
  String get optionalMessage => _message;
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

abstract class IFilter {
  int get filter;
}

abstract class IPath {
  String get path;
}

class Path implements IPath {
  final String _path;

  const Path(this._path);

  @override
  String get path => _path;
}

class PathWithFilter extends Path implements IFilter {
  final int _filter;

  const PathWithFilter(final String path, [this._filter]) : super(path);

  @override
  int get filter => _filter;
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
