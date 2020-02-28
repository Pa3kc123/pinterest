import 'util.dart';

class PinterestMessage<T> extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _status;
  JsonProperty<int> _code;
  JsonProperty<T> _data;
  JsonProperty<String> _message;
  JsonProperty<String> _type;

  PinterestMessage([
    this._status,
    this._code,
    this._data,
    this._message,
    this._type
  ]);

  String get status => _status?.value;
  int get statusCode => _code?.value;
  T get data => _data?.value;
  String get message => _message?.value;
  String get type => _type?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _status = decoder.getAndCast<String>('status');
    _code = decoder.getAndCast<int>('code');
    _data = decoder.getAndCast<T>('data');
    _message = decoder.getAndCast<String>('message');
    _type = decoder.getAndCast<String>('type');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_status, _code, _data, _message, _type]);
}

class SectionInfo extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _id;

  SectionInfo([
    this._id
  ]);

  String get id => _id?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _id = decoder.getAndCast<String>('id');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_id]);
}

class BoardInfo extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _id;
  JsonProperty<String> _name;
  JsonProperty<Uri> _url;
  JsonProperty<String> _description;
  JsonProperty<PinCreator> _creator;
  JsonProperty<DateTime> _createdAt;
  JsonProperty<PinCounts> _counts;
  JsonProperty<PinImageCollection> _image;
  JsonProperty<PinPrivacy> _privacy;
  JsonProperty<PinReason> _reason;

  BoardInfo([
    this._id,
    this._name,
    this._url,
    this._description,
    this._creator,
    this._createdAt,
    this._counts,
    this._image,
    this._privacy,
    this._reason
  ]);

  String get id => _id?.value;
  String get name => _name?.value;
  Uri get url => _url?.value;
  String get description => _description?.value;
  PinCreator get creator => _creator?.value;
  DateTime get createdAt => _createdAt?.value;
  PinCounts get counts => _counts?.value;
  PinImageCollection get image => _image?.value;
  PinPrivacy get privacy => _privacy?.value;
  PinReason get reason => _reason?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _id = decoder.getAndCast<String>('id');
    _name = decoder.getAndCast<String>('name');
    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _description = decoder.getAndCast<String>('description');
    _creator = decoder.getAndParse<Map<String, dynamic>, PinCreator>('creator', (Map<String, dynamic> value) => PinCreator()..decode(value));
    _createdAt = decoder.getAndParse<String, DateTime>('created_at', (String value) => DateTime.tryParse(value));
    _counts = decoder.getAndParse<Map<String, dynamic>, PinCounts>('counts', (Map<String, dynamic> value) => PinCounts()..decode(value));
    _image = decoder.getAndParse<Map<String, dynamic>, PinImageCollection>('image', (Map<String, dynamic> value) => PinImageCollection()..decode(value));
    _privacy = decoder.getAndParse<String, PinPrivacy>('privacy', (String value) => PinPrivacy()..decode(value));
    _reason = decoder.getAndParse<String, PinReason>('reason', (String value) => PinReason()..decode(value));
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_id, _name, _url, _description, _creator, _createdAt, _counts, _image, _privacy, _reason]);
}

class PinInfo extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _id;
  JsonProperty<Uri> _link;
  JsonProperty<Uri> _url;
  JsonProperty<PinCreator> _creator;
  JsonProperty<BoardInfo> _board;
  JsonProperty<DateTime> _createdAt;
  JsonProperty<String> _note;
  JsonProperty<String> _color;
  JsonProperty<PinCounts> _counts;
  JsonProperty<PinMedia> _media;
  JsonProperty<PinAttribution> _attribution;
  JsonProperty<PinImageCollection> _image;
  JsonProperty<PinMetadata> _metadata;

  PinInfo([
    this._id,
    this._link,
    this._url,
    this._creator,
    this._board,
    this._createdAt,
    this._note,
    this._color,
    this._counts,
    this._media,
    this._attribution,
    this._image,
    this._metadata
  ]);

  String get id => _id?.value;
  Uri get link => _link?.value;
  Uri get url => _url?.value;
  PinCreator get creator => _creator?.value;
  BoardInfo get board => _board?.value;
  DateTime get createdAt => _createdAt?.value;
  String get note => _note?.value;
  String get color => _color?.value;
  PinCounts get counts => _counts?.value;
  PinMedia get media => _media?.value;
  PinAttribution get attribution => _attribution?.value;
  PinImageCollection get image => _image?.value;
  PinMetadata get metadata => _metadata?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _id = decoder.getAndCast<String>('id');
    _link = decoder.getAndParse<String, Uri>('link', (String value) => Uri.tryParse(value));
    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _creator = decoder.getAndParse<Map<String, dynamic>, PinCreator>('creator', (Map<String, dynamic> value) => PinCreator()..decode(value));
    _board = decoder.getAndParse<Map<String, dynamic>, BoardInfo>('board', (Map<String, dynamic> value) => BoardInfo()..decode(value));
    _createdAt = decoder.getAndParse<String, DateTime>('createdAt', (String value) => DateTime.tryParse(value));
    _note = decoder.getAndCast<String>('note');
    _color = decoder.getAndCast<String>('color');
    _counts = decoder.getAndParse<Map<String, dynamic>, PinCounts>('counts', (Map<String, dynamic> value) => PinCounts()..decode(value));
    _media = decoder.getAndParse<Map<String, dynamic>, PinMedia>('media', (Map<String, dynamic> value) => PinMedia()..decode(value));
    _attribution = decoder.getAndParse<Map<String, dynamic>, PinAttribution>('attribution', (Map<String, dynamic> value) => PinAttribution()..decode(value));
    _image = decoder.getAndParse<Map<String, dynamic>, PinImageCollection>('image', (Map<String, dynamic> value) => PinImageCollection()..decode(value));
    _metadata = decoder.getAndParse<Map<String, dynamic>, PinMetadata>('metadata', (Map<String, dynamic> value) => PinMetadata()..decode(value));
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_id, _link, _url, _creator, _board, _createdAt, _note, _color, _counts, _media, _attribution, _image, _metadata]);
}

class UserInfo extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _username;
  JsonProperty<String> _bio;
  JsonProperty<String> _firstName;
  JsonProperty<String> _lastName;
  JsonProperty<String> _accountType;
  JsonProperty<Uri> _url;
  JsonProperty<DateTime> _createdAt;
  JsonProperty<PinImageCollection> _image;
  JsonProperty<PinCounts> _counts;
  JsonProperty<String> _id;

  UserInfo([
    this._username,
    this._bio,
    this._firstName,
    this._lastName,
    this._accountType,
    this._url,
    this._createdAt,
    this._image,
    this._counts,
    this._id
  ]);

  String get username => _username?.value;
  String get bio => _bio?.value;
  String get firstName => _firstName?.value;
  String get lastName => _lastName?.value;
  String get accountType => _accountType?.value;
  Uri get url => _url?.value;
  DateTime get createdAt => _createdAt?.value;
  PinImageCollection get image => _image?.value;
  PinCounts get counts => _counts?.value;
  String get id => _id?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _username = decoder.getAndCast<String>('username');
    _bio = decoder.getAndCast<String>('bio');
    _firstName = decoder.getAndCast<String>('first_name');
    _lastName = decoder.getAndCast<String>('last_name');
    _accountType = decoder.getAndCast<String>('account_type');
    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _createdAt = decoder.getAndParse<String, DateTime>('created_at', (String value) => DateTime.tryParse(value));
    _image = decoder.getAndParse<Map<String, dynamic>, PinImageCollection>('image', (Map<String, dynamic> value) => PinImageCollection()..decode(value));
    _counts = decoder.getAndParse<Map<String, dynamic>, PinCounts>('counts', (Map<String, dynamic> value) => PinCounts()..decode(value));
    _id = decoder.getAndCast<String>('id');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_username, _bio, _firstName, _lastName, _accountType, _url, _createdAt, _image, _counts, _id]);
}

class PinAttribution extends AJsonData<dynamic> {
  JsonProperty<dynamic> _value;

  PinAttribution([
    this._value
  ]);

  dynamic get value => _value?.value;

  @override
  void decode(dynamic json) => _value = json;

  @override
  Map<String, dynamic> encode() => encodeValues([_value]);
}

class PinCreator extends AJsonData<Map<String, dynamic>> {
  JsonProperty<Uri> _url;
  JsonProperty<String> _firstName;
  JsonProperty<String> _lastName;
  JsonProperty<String> _id;

  PinCreator([
    this._url,
    this._firstName,
    this._lastName,
    this._id
  ]);

  Uri get url => _url?.value;
  String get firstName => _firstName?.value;
  String get lastName => _lastName?.value;
  String get id => _id?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _firstName = decoder.getAndCast<String>('first_name');
    _lastName = decoder.getAndCast<String>('last_name');
    _id = decoder.getAndCast<String>('id');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_url, _firstName, _lastName, _id]);
}

class PinCounts extends AJsonData<Map<String, dynamic>> {
  JsonProperty<int> _pins;
  JsonProperty<int> _collaborators;
  JsonProperty<int> _followers;

  PinCounts([
    this._pins,
    this._collaborators,
    this._followers
  ]);

  int get pins => _pins?.value;
  int get collaborators => _collaborators?.value;
  int get followers => _followers?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _pins = decoder.getAndCast<int>('pins');
    _collaborators = decoder.getAndCast<int>('collaborators');
    _followers = decoder.getAndCast<int>('followers');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_pins, _collaborators, _followers]);
}

class PinImage extends AJsonData<Map<String, dynamic>> {
  JsonProperty<Uri> _url;
  JsonProperty<int> _width;
  JsonProperty<int> _height;

  PinImage([
    this._url,
    this._width,
    this._height
  ]);

  Uri get url => _url?.value;
  int get width => _width?.value;
  int get height => _height?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _width = decoder.getAndCast<int>('width');
    _height = decoder.getAndCast<int>('height');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_url, _width, _height]);
}

class PinImageCollection extends AJsonData<Map<String, dynamic>> {
  List<JsonProperty<PinImage>> _collection;

  PinImageCollection([
    this._collection
  ]);

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);
    _collection = List<JsonProperty<PinImage>>(json.keys.length);

    var i = 0;
    for (final key in json.keys) {
      _collection[i] = decoder.getAndParse<Map<String, dynamic>, PinImage>(key, (Map<String, dynamic> value) => PinImage()..decode(value));
    }
  }

  PinImage operator [](int index) => _collection[index]?.value;

  bool get isEmpty => _collection?.isEmpty ?? false;
  bool get isNotEmpty => _collection?.isNotEmpty ?? false;

  PinImage get first => _collection[0]?.value;

  @override
  Map<String, dynamic> encode() => encodeValues(_collection);
}

class PinMedia extends AJsonData<Map<String, dynamic>> {
  JsonProperty<PinMediaType> _type;

  PinMedia([
    this._type
  ]);

  PinMediaType get type => _type.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _type = decoder.getAndParse<String, PinMediaType>('type', (String value) => PinMediaType()..decode(value));
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_type]);
}

class PinMediaType extends AJsonData<String> {
  static final PinMediaType IMAGE = PinMediaType._('image');

  String _type;

  PinMediaType();
  PinMediaType._(this._type);

  @override
  void decode(String value) {
    switch (value) {
      case 'image': _type = IMAGE._type; break;
    }
  }

  @override
  Map<String, dynamic> encode() => {
    'type': _type
  };
}

class PinMetadata extends AJsonData<Map<String, dynamic>> {
  JsonProperty<PinMetadataLink> _link;

  PinMetadata([
    this._link
  ]);

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _link = decoder.getAndParse<Map<String, dynamic>, PinMetadataLink>('link', (Map<String, dynamic> value) => PinMetadataLink()..decode(value));
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_link]);
}

class PinMetadataLink extends AJsonData<Map<String, dynamic>> {
  PinMetadataLink();

  @override
  void decode(Map<String, dynamic> json) => null;

  @override
  Map<String, dynamic> encode() => null;
}

class PinPage extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _cursor;
  JsonProperty<Uri> _next;

  PinPage([
    this._cursor,
    this._next
  ]);

  String get cursor => _cursor?.value;
  Uri get next => _next?.value;

  @override
  void decode(Map<String, dynamic> json) {
    if (json == null) return null;

    final decoder = JsonDecoder(json);

    _cursor = decoder.getAndCast<String>('cursor');
    _next = decoder.getAndParse<String, Uri>('next', (String value) => Uri.tryParse(value));
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_cursor, _next]);
}

class PinPrivacy extends AJsonData<String> {
  static final PinPrivacy PUBLIC = PinPrivacy._('public');
  static final PinPrivacy PRIVATE = PinPrivacy._('private');

  String _privacy;

  PinPrivacy();
  PinPrivacy._(this._privacy);

  @override
  void decode(String value) {
    switch (value) {
      case 'public': _privacy = PUBLIC._privacy; break;
      case 'private': _privacy = PRIVATE._privacy; break;
    }
  }

  @override
  Map<String, dynamic> encode() => {
    'privacy': _privacy
  };
}

class PinReason extends AJsonData<String> {
  static final PinReason RECENTLY_PICKED = PinReason._('Recently picked');

  String _reason;

  PinReason();
  PinReason._([
    this._reason
  ]);

  @override
  void decode(String reason) {
    switch (reason) {
      case 'Recently picked': _reason = RECENTLY_PICKED._reason; return;
    }
  }

  @override
  Map<String, dynamic> encode() => {
    'reason': _reason
  };
}
