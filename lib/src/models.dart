import 'util.dart';

class PinterestMessage extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _status;
  JsonProperty<int> _code;
  JsonProperty<Map<String, dynamic>> _data;
  JsonProperty<String> _message;

  PinterestMessage([
    this._status,
    this._code,
    this._data,
    this._message
  ]);

  String get status => _status?.value;
  int get code => _code?.value;
  Map<String, dynamic> get data => _data?.value;
  String get message => _message?.value;

  @override
  void decode(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    _status = decoder.getAndCast<String>('status');
    _code = decoder.getAndCast<int>('code');
    _data = decoder.getAndCast<Map<String, dynamic>>('data');
    _message = decoder.getAndCast<String>('message');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_status, _code, _data, _message]);
}

class SectionInfo extends AJsonData<Map<String, dynamic>> {
  JsonProperty<String> _id;

  SectionInfo([
    this._id
  ]);

  String get id => _id?.value;

  @override
  void decode(Map<String, dynamic> json) {
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
    final decoder = JsonDecoder(json);

    _id = decoder.getAndCast<String>('id');
    _name = decoder.getAndCast<String>('name');
    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _description = decoder.getAndCast<String>('description');
    _creator = decoder.getAndParse<Map<String, dynamic>, PinCreator>('creator', (Map<String, dynamic> value) => PinCreator()..decode(value));
    _createdAt = decoder.getAndParse<String, DateTime>('created_at', (String value) => DateTime.tryParse(value));
    _counts = decoder.getAndParse<Map<String, dynamic>, PinCounts>('counts', (Map<String, dynamic> value) => PinCounts()..decode(value));
    _image = decoder.getAndParse<Map<String, dynamic>, PinImageCollection>('image', (Map<String, dynamic> value) => PinImageCollection()..decode(value));
    _privacy = decoder.getAndParse<String, PinPrivacy>('privacy', (String value) => PinPrivacy.fromString(value));
    _reason = decoder.getAndParse<String, PinReason>('reason', (String value) => PinReason.fromString(value));
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
    final decoder = JsonDecoder(json);

    _username = decoder.getAndCast<String>('username');
    _bio = decoder.getAndCast<String>('bio');
    _firstName = decoder.getAndCast<String>('firstName');
    _lastName = decoder.getAndCast<String>('lastName');
    _accountType = decoder.getAndCast<String>('accountType');
    _url = decoder.getAndParse<String, Uri>('url', (String value) => Uri.tryParse(value));
    _createdAt = decoder.getAndParse<String, DateTime>('createdAt', (String value) => DateTime.tryParse(value));
    _image = decoder.getAndParse<Map<String, dynamic>, PinImageCollection>('image', (Map<String, dynamic> value) => PinImageCollection()..decode(value));
    _counts = decoder.getAndParse<Map<String, dynamic>, PinCounts>('counts', (Map<String, dynamic> value) => PinCounts()..decode(value));
    _id = decoder.getAndCast<String>('id');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_username, _bio, _firstName, _lastName, _accountType, _url, _createdAt, _image, _counts, _id]);
}

class PinAttribution {
  const PinAttribution();
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
    final decoder = JsonDecoder(json);
    _collection = List<JsonProperty<PinImage>>(json.keys.length);

    json.keys.forEach((String key) => _collection.add(
      decoder.getAndParse<Map<String, dynamic>, PinImage>(key, (Map<String, dynamic> value) => PinImage()..decode(value)))
    );
  }

  PinImage operator [](int index) => _collection[index]?.value;

  bool get isEmpty => _collection?.isEmpty ?? false;
  bool get isNotEmpty => _collection?.isNotEmpty ?? false;

  PinImage get first => _collection[0]?.value;

  @override
  String toString() => _collection?.toString();

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
    final decoder = JsonDecoder(json);

    _type = decoder.getAndParse<String, PinMediaType>('type', (String value) => PinMediaType()..decode(value));
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_type]);
}

class PinMediaType extends AJsonData<String> {
  static const PinMediaType IMAGE = PinMediaType._('image');

  final String _type;

  const PinMediaType._(this._type) : super();

  @override
  void decode(String value) {
    if (value == null) return null;
    switch (value) {
      case 'image': return IMAGE;
      default: return null;
    }
  }

  @override
  String encode() => const '';
}

class PinMetadata {
  final JsonProperty<PinMetadataLink> link;

  const PinMetadata._(
    this.link
  );

  factory PinMetadata()..decode(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    final JsonProperty<Map<String, String>> linkMap = decoder.getAndCast<Map<String, String>>('link');
    final JsonProperty<PinMetadataLink> link = linkMap != null ? linkMap.getAndParse<PinMetadataLink>((Map<String, String> map) => PinMetadataLink()..decode(map)) : null;

    return PinMetadata._(link);
  }
}

class PinMetadataLink {
  const PinMetadataLink();

  factory PinMetadataLink()..decode(Map<String, String> json) {
    return null;
  }
}

class PinPage {
  final String cursor;
  final Uri next;

  const PinPage._(
    this.cursor,
    this.next
  );

  factory PinPage()..decode(Map<String, dynamic> json) {
    final cursor = json['cursor'] as String;

    final nextString = json['next'] as String;
    final next = nextString != null ? Uri.tryParse(nextString) : null;

    return PinPage._(cursor, next);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'cursor': cursor,
    'next': next
  };

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('cursor = ${cursor}');
    buffer.writeln('next = ${next}');

    return buffer.toString();
  }
}

class PinPrivacy {
  static const PinPrivacy PUBLIC = PinPrivacy._('public');
  static const PinPrivacy PRIVATE = PinPrivacy._('private');

  final String privacy;

  const PinPrivacy._(
    this.privacy
  );

  factory PinPrivacy.fromString(String privacy) {
    switch (privacy) {
      case 'public': return PUBLIC;
      case 'private': return PRIVATE;
      default: return null;
    }
  }

  Map<String, String> toJson() => <String, String>{
    'privacy': privacy
  };

  @override
  String toString() => privacy;
}

class PinReason {
  static const PinReason RECENTLY_PICKED = PinReason._('Recently picked');

  final String reason;

  const PinReason._(
    this.reason
  );

  factory PinReason.fromString(String reason) {
    switch (reason) {
      case 'Recently picked': return RECENTLY_PICKED;
      default: return null;
    }
  }

  Map<String, String> toJson() => <String, String>{
    'reason': reason
  };

  @override
  String toString() => reason;
}
