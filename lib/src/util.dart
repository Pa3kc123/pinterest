import 'dart:io';

import 'core.dart';

//Models
abstract class IEncodable {
  Map<String, dynamic> encode();
}

abstract class IDecodable<T> {
  void decode(T json);
}

abstract class AJsonData<T> implements IEncodable, IDecodable<T> {
  @override
  String toString() => log(this);
}

Map<String, dynamic> encodeValues(List<JsonProperty<dynamic>> values) {
  final map = <String, dynamic>{};

  for (var value in values) {
    if (value != null) {
      map[value.name] = value.value;
    } else {
      continue;
    }
  }

  return map;
}

//Exceptions
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

//Json decoding
class JsonProperty<T> {
  String _name;
  T _value;

  JsonProperty(this._name, this._value);

  String get name => _name;
  T get value => _value;

  set name(String name) => _name = name;
  set value(T value) => _value = value;

  @override
  String toString() => '"$name":"$value" (${value.runtimeType})';
}

class JsonDecoder {
  final Map<String, dynamic> json;

  const JsonDecoder(this.json);

  JsonProperty<T> getAndCast<T>(String name) => JsonProperty<T>(name, json[name] as T);

  JsonProperty<E> getAndParse<T, E>(String name, E Function(T value) parser) {
    final property = getAndCast<T>(name);

    E result;
    if (property.value != null) {
      result = parser?.call(property.value) ?? property.value as E;
    }

    return JsonProperty(property.name, result);
  }
}

//Http header helper
class HttpHeaderDecoder {
  final HttpHeaders headers;

  const HttpHeaderDecoder(this.headers);

  T getAndParse<T>(final String headerName, T Function(String value) parser) {
    final header = headers.value(headerName);
    return header != null ? parser?.call(header) : null;
  }
}

//Pathing
abstract class IFilter {
  int get filter;
}

abstract class IPath {
  String get path;
  Map<String, String> get replacements;
}

class Path implements IPath {
  final String _path;
  final Map<String, String> _replacements;

  const Path(this._path, [this._replacements]);

  factory Path._(String path) {
    var replacements = <String, String>{};

    var startIndex = path.indexOf('<');
    if (startIndex != -1) {
      for (var endIndex = path.indexOf('>'); startIndex != -1 || endIndex != -1; startIndex = path.indexOf('<', endIndex), endIndex = path.indexOf('>', startIndex)) {
        var tmpIndex = startIndex + 1;

        if (tmpIndex < endIndex) continue;

        replacements[path.substring(tmpIndex, endIndex)] = null;
      }
    }

    return Path(path, replacements);
  }

  @override
  String get path => _path;

  @override
  Map<String, String> get replacements => _replacements;
}

class PathWithFilter extends Path implements IFilter {
  final int _filter;

  const PathWithFilter(final String path, [this._filter]) : super(path);

  @override
  int get filter => _filter;
}

//Util
int _tabs = 0;
String log(IEncodable parser) {
  final buffer = StringBuffer();

  final map = parser.encode();

  buffer.writeln('{');
  _tabs++;

  String tab;
  for (var key in map.keys) {
    tab = '';

    for (var i = _tabs * 2; i >= 1; i--) {
      tab += ' ';
    }

    buffer.writeln('$tab$key = ${map[key].toString()}');
  }

  _tabs--;
  buffer.write('${tab.replaceRange(0, 2, "")}}');

  return buffer.toString();
}
