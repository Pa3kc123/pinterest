import 'util.dart';
import 'util.dart';
import 'util.dart';

class PinterestMessage implements IJsonData {
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

  JsonProperty<String> get status => _status;
  JsonProperty<int> get code => _code;
  JsonProperty<Map<String, dynamic>> get data => _data;
  JsonProperty<String> get message => _message;

  @override
  void decode(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    _status = decoder.get<String>('status');
    _code = decoder.get<int>('code');
    _data = decoder.get<Map<String, dynamic>>('data');
    _message = decoder.get<String>('message');
  }

  @override
  Map<String, dynamic> encode() => encodeValues(<JsonProperty>[_status, _code, _data, _message]);
}

class SectionInfo implements IJsonData {
  JsonProperty<String> _id;

  SectionInfo([
    this._id
  ]);

  JsonProperty<String> get id => _id;

  @override
  void decode(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    _id = decoder.get<String>('id');
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_id]);
}

class BoardInfo implements IJsonData {
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

  @override
  void decode(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    _id = decoder.get<String>('id');
    _name = decoder.get<String>('name');

    final urlString = decoder.get<String>('url');
    _url = (urlString.value?.isNotEmpty ?? false) ? urlString.cast<Uri>((String value) => Uri.tryParse(value)) : null;

    _description = decoder.get<String>('description');

    final creatorMap = decoder.get<Map<String, dynamic>>('creator');
    _creator = creatorMap.value != null ? creatorMap.cast<PinCreator>((Map<String, dynamic> value) => PinCreator.fromJson(value)) : null;

    final createdAtString = decoder.get<String>('created_at');
    _createdAt = (createdAtString.value?.isNotEmpty ?? false) ? createdAtString.cast<DateTime>((String value) => DateTime.tryParse(value)) : null;

    final countsMap = decoder.get<Map<String, dynamic>>('counts');
    _counts = countsMap != null ? countsMap.cast<PinCounts>((Map<String, dynamic> value) => PinCounts.fromJson(value)) : null;

    final imageMap = decoder.get<Map<String, PinImageCollection>>('image');
    _image = imageMap.value != null ? imageMap.cast<PinImageCollection>((Map<String, PinImageCollection> value) => PinImageCollection.fromJson(imageMap.value)) : null;

    final privacyString =  decoder.get<String>('privacy');
    _privacy = privacyString != null ? privacyString.cast<PinPrivacy>((String value) => PinPrivacy.fromString(privacyString.value)) : null;

    final reasonString = decoder.get<String>('reason');
    _reason = reasonString != null ? reasonString.cast<PinReason>((String value) => PinReason.fromString(reasonString.value)) : null;
  }

  @override
  Map<String, dynamic> encode() => encodeValues([_id, _name, _url, _description, _creator, _createdAt, _counts, _image, _privacy, _reason]);
}

class PinInfo implements IJsonData {
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

  @override
  void decode(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    _id = decoder.get<String>('id');

    final linkString = json['link'] as String;
    _link = (linkString?.isNotEmpty ?? false) ? Uri.tryParse(linkString) : null;

    final urlString = json['url'] as String;
    _url = (urlString?.isNotEmpty ?? false) ? Uri.tryParse(urlString) : null;

    final creatorMap = json['creator'] as Map<String, String>;
    _creator = creatorMap != null ? PinCreator.fromJson(creatorMap) : null;
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}

class UserInfo extends PinData {
  final String username;
  final String bio;
  final String firstName;
  final String lastName;
  final String accountType;
  final Uri url;
  final DateTime createdAt;
  final PinImageCollection image;
  final PinCounts counts;
  final String id;

  const UserInfo._(
    this.username,
    this.bio,
    this.firstName,
    this.lastName,
    this.accountType,
    this.url,
    this.createdAt,
    this.image,
    this.counts,
    this.id,
    int rateLimit,
    int rateRemaining
  ) : super._(false, rateLimit, rateRemaining);

  factory UserInfo.fromJson(Map<String, dynamic> json, int rateLimit, int rateRemaining) {
    final username = json['username'] as String;
    final bio = json['bio'] as String;
    final firstName = json['first_name'] as String;
    final lastName = json['last_name'] as String;
    final accountType = json['account_type'] as String;

    final urlString = json['url'] as String;
    final url = urlString != null ? Uri.tryParse(urlString) : null;

    final createdAtString = json['createdAt'] as String;
    final createdAt = createdAtString != null ? DateTime.tryParse(createdAtString) : null;

    final image = PinImageCollection.fromJson(json['image']);
    final counts = PinCounts.fromJson(json['counts']);

    final id = json['id'] as String;

    return UserInfo._(username, bio, firstName, lastName, accountType, url, createdAt, image, counts, id, rateLimit, rateRemaining);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'username': username,
    'bio': bio,
    'first_name': firstName,
    'last_name': lastName,
    'account_type': accountType,
    'url': url,
    'created_at': createdAt,
    'image': image.toJson(),
    'counts': counts.toJson(),
    'id': id
  }..addAll(super.toJson());
}

class PinAttribution {
  const PinAttribution();
}

class PinCreator {
  final Uri url;
  final String firstName;
  final String lastName;
  final String id;

  const PinCreator._(
    this.url,
    this.firstName,
    this.lastName,
    this.id
  );

  factory PinCreator.fromJson(Map<String, dynamic> json) {
    final urlString = json['uri'] as String;
    final url = urlString != null ? Uri.tryParse(urlString) : null;

    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    final id = json['id'] as String;

    return PinCreator._(url, firstName, lastName, id);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': url,
    'firstName': firstName,
    'lastName': lastName,
    'id': id
  };

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('url = ${url}');
    buffer.writeln('firstName = ${firstName}');
    buffer.writeln('lastName = ${lastName}');
    buffer.writeln('id = ${id}');

    return super.toString();
  }
}

class PinCounts {
  final int pins;
  final int collaborators;
  final int followers;

  const PinCounts._(
    this.pins,
    this.collaborators,
    this.followers
  );

  factory PinCounts.fromJson(Map<String, dynamic> json) {
    final pins = json['pins'] as int;
    final collaborators = json['collaborators'] as int;
    final followers = json['followers'] as int;

    return PinCounts._(pins, collaborators, followers);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'pins': pins,
    'collaborators': collaborators,
    'followers': followers
  };
}

class PinImage {
  final Uri url;
  final int width;
  final int height;

  const PinImage._(
    this.url,
    this.width,
    this.height
  );

  factory PinImage.fromJson(Map<String, dynamic> json) {
    final urlString = json['url'] as String;
    final uri = urlString != null ? Uri.tryParse(urlString) : null;

    final width = json['width'] as int;
    final height = json['height'] as int;

    return PinImage._(uri, width, height);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': url,
    'width': width,
    'height': height
  };

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('url = $url');
    buffer.writeln('width = $width');
    buffer.writeln('height = $height');

    return buffer.toString();
  }
}

class PinImageCollection {
  final List<PinImage> _collection;

  const PinImageCollection._(
    this._collection
  );

  factory PinImageCollection.fromJson(Map<String, dynamic> json) {
    final collection = List<PinImage>(json.keys.length);

    json.keys.forEach((String key) => collection.add(PinImage.fromJson(json[key])));

    return PinImageCollection._(collection);
  }

  PinImage operator [](int index) => _collection[index];

  bool get isEmpty => _collection.isEmpty;
  bool get isNotEmpty => _collection.isNotEmpty;

  PinImage get first => _collection[0];

  Map<String, dynamic> toJson() => const <String, dynamic>{};

  @override
  String toString() => _collection.toString();
}

class PinMedia {
  final JsonProperty<PinMediaType> type;

  const PinMedia._(this.type);

  factory PinMedia.fromJson(Map<String, String> json) {
    final decoder = JsonDecoder(json);

    final typeString = decoder.get<String>('type');
    final JsonProperty<PinMediaType> type = typeString != null ? typeString.cast<PinMediaType>((String value) =>  PinMediaType.fromString(value)) : null;

    return PinMedia._(type);
  }
}

class PinMediaType {
  static const PinMediaType IMAGE = PinMediaType._('image');

  final String type;

  const PinMediaType._(this.type);

  factory PinMediaType.fromString(String value) {
    if (value == null) return null;
    switch (value) {
      case 'image': return IMAGE;
      default: return null;
    }
  }
}

class PinMetadata {
  final JsonProperty<PinMetadataLink> link;

  const PinMetadata._(
    this.link
  );

  factory PinMetadata.fromJson(Map<String, dynamic> json) {
    final decoder = JsonDecoder(json);

    final JsonProperty<Map<String, String>> linkMap = decoder.get<Map<String, String>>('link');
    final JsonProperty<PinMetadataLink> link = linkMap != null ? linkMap.cast<PinMetadataLink>((Map<String, String> map) => PinMetadataLink.fromJson(map)) : null;

    return PinMetadata._(link);
  }
}

class PinMetadataLink {
  const PinMetadataLink();

  factory PinMetadataLink.fromJson(Map<String, String> json) {
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

  factory PinPage.fromJson(Map<String, dynamic> json) {
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
