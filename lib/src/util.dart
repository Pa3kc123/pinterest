class ConstCollection<T> extends Iterable<T> {
  final List<T> _values;

  const ConstCollection(List<T> values) : this._values = values;

  int get length => this._values.length;

  T operator [](int index) => this._values[index];

  @override
  Iterator<T> get iterator => _ConstCollectionIterator(this);
}

class _ConstCollectionIterator<T> implements Iterator<T> {
  final ConstCollection<T> _collection;
  int index = 0;

  _ConstCollectionIterator(this._collection);

  @override
  get current => _collection[index];

  @override
  bool moveNext() => ++index < this._collection.length;
}

abstract class Parser<T> {
  Map<String, T> toJson();
}

class JsonProperty<T> {
  final String name;
  final T value;

  const JsonProperty._(this.name, this.value);

  JsonProperty cast<E>(E Function(T value) parser) => JsonProperty._(this.name, parser(this.value));
}

class JsonDecoder {
  final Map<String, dynamic> json;

  const JsonDecoder(this.json);

  JsonProperty get<T>(String name) {
    final dynamic value = this.json[name];

    if (value == null) return null;

    return JsonProperty._(name, value as T);
  }
}

String log(Parser<dynamic> parser) {
  final StringBuffer buffer = StringBuffer();

  final Map<String, dynamic> map = parser.toJson();

  for (String key in map.keys) {
    buffer.writeln('$key = ${map[key].toString()}');
  }

  return buffer.toString();
}
