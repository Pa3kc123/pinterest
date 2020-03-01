class JsonData {
  final String type;

  const JsonData(this.type);
}

class JsonProperty {
  final String key;
  final int type;

  const JsonProperty._(this.key, this.type);
}

class CastableJsonProperty extends JsonProperty {
  const CastableJsonProperty(String key) : super._(key, CAST);
}

class ParseableJsonProperty extends JsonProperty {
  final String baseType;
  final String parseFunc;

  const ParseableJsonProperty(String key, this.baseType, this.parseFunc) : super._(key, PARSE);
}

const int CAST = 0x0;
const int PARSE = 0x1;
