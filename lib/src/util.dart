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

abstract class Encodable<T> {
  Map<String, T> encode();
}

abstract class Decodable<T> {
  void decode(T json);
}

abstract class Generator<T> {
  T generate();
}

class JsonProperty<T> {
  final String name;
  final T value;

  const JsonProperty(this.name, this.value);
}

class JsonDecoder {
  final Map<String, dynamic> json;

  const JsonDecoder(this.json);

  JsonProperty<T> get<T>(String name) => JsonProperty<T>(name, this.json[name] as T);

  JsonProperty<E> getAndCast<T, E>(String name, [E Function(T value) parser]) {
    final JsonProperty<T> property = this.get<T>(name);

    return JsonProperty(property.name, parser == null ? property.value as E : parser(property.value));
  }
}

int tabs = 0;
String log(Encodable<dynamic> parser) {
  final StringBuffer buffer = StringBuffer();

  final Map<String, dynamic> map = parser.encode();

  buffer.writeln('{');
  tabs++;

  String tab;
  for (String key in map.keys) {
    tab = "";

    for (int i = tabs * 2; i >= 1; i--) {
      tab += " ";
    }

    buffer.writeln('$tab$key = ${map[key].toString()}');
  }

  tabs--;
  buffer.write('${tab.replaceRange(0, 2, "")}}');

  return buffer.toString();
}
