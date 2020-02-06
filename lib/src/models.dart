import 'package:pinterest/src/util.dart';

class PinData implements Parser<dynamic> {
  final bool errorOccured;
  final int rateLimit;
  final int rateRemaining;

  const PinData._(
    this.errorOccured,
    this.rateLimit,
    this.rateRemaining
  );

  factory PinData.fromJson(Map<String, dynamic> json, int rateLimit, int rateRemaining) {
    return PinData._(null, rateLimit, rateRemaining);
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
    'errorOccured': this.errorOccured,
    'rateLimit': this.rateLimit,
    'rateRemaining': this.rateRemaining
  };

  @override
  String toString() => log(this);
}

class PinErrorData extends PinData {
  final JsonProperty<String> status;
  final JsonProperty<String> message;
  final JsonProperty<int> code;
  final JsonProperty<dynamic> data;
  final JsonProperty<String> type;
  final int statusCode;

  const PinErrorData._(
    this.status,
    this.message,
    this.code,
    this.data,
    this.type,
    this.statusCode,
    int rateLimit,
    int rateRemaining
  ) : super._(true, rateLimit, rateRemaining);

  factory PinErrorData.fromJson(Map<String, dynamic> json, int statusCode, int rateLimit, int rateRemaining) {
    final JsonDecoder decoder = JsonDecoder(json);

    final JsonProperty<String> status = decoder.get<String>('status');
    final JsonProperty<String> message = decoder.get<String>('message');
    final JsonProperty<int> code = decoder.get<int>('code');
    final JsonProperty<dynamic> data = decoder.get<dynamic>('data');
    final JsonProperty<String> type = decoder.get<String>('type');

    return PinErrorData._(status, message, code, data, type, statusCode, rateLimit, rateRemaining);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      'status': this.status,
      'message': this.message,
      'code': this.code,
      'data': this.data,
      'type': this.type,
      'statusCode': this.statusCode
    };

    map.addAll(super.toJson());

    return map;
  }
}

class SectionInfo extends PinData {
  final JsonProperty<String> id;

  const SectionInfo._(
    this.id,
    int rateLimit,
    int rateRemaining
  ) : super._(false, rateLimit, rateRemaining);

  factory SectionInfo.fromString(String value, int rateLimit, int rateRemaining) {
    final JsonProperty<String> id = JsonProperty<String>('id', value.substring(value.indexOf(' ') + 1, value.length - 1));

    return SectionInfo._(id, rateLimit, rateRemaining);
  }

  @override
  Map<String, String> toJson() {
    final Map<String, String> map = <String, String>{
      this.id.name: this.id.value
    };

  factory PinRootData.fromJson(Map<String, dynamic> json, [int rateLimit, int rateRemaining]) {
    final data = json['data'] as dynamic;
    final isDataListType = data is List;
    map.addAll(super.toJson());

    return map;
  }
}

class BoardInfo extends PinData {
  final JsonProperty<String> id;
  final JsonProperty<String> name;
  final JsonProperty<Uri> url;
  final JsonProperty<String> description;
  final JsonProperty<PinCreator> creator;
  final JsonProperty<DateTime> createdAt;
  final JsonProperty<PinCounts> counts;
  final JsonProperty<PinImageCollection> image;

  final JsonProperty<PinPrivacy> privacy;
  final JsonProperty<PinReason> reason;

  const BoardInfo._(
    this.id,
    this.name,
    this.url,
    this.description,
    this.creator,
    this.createdAt,
    this.counts,
    this.image,
    this.privacy,
    this.reason,
    int rateLimit,
    int rateRemaining
  ) : super._(false, rateLimit, rateRemaining);

  factory BoardInfo.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String;

    final creator = PinCreator.fromJson(json['creator'] as Map<String, dynamic>);

    final urlString = json['url'] as String;
    final url = urlString != null ? Uri.tryParse(urlString) : null;

    final createAtString = json['created_at'] as String;
    final createdAt = createAtString != null ? DateTime.tryParse(createAtString) : null;

    final privacy = PinPrivacy.fromString(json['privacy'] as String);
    final reason = PinReason.fromString(json['reason'] as String);

    final image = PinImageCollection.fromJson(json['image'] as Map<String, dynamic>);

    final countsMap = json['counts'] as Map<String, dynamic>;
    final counts = countsMap != null ? PinCounts.fromJson(countsMap) : null;

    final id = json['id'] as String;
    final description = json['description'] as String;
  factory BoardInfo.fromJson(Map<String, dynamic> json, int rateLimit, int rateRemaining) {
    final JsonDecoder decoder = JsonDecoder(json);

    final JsonProperty<String> id = decoder.get<String>('id');
    final JsonProperty<String> name = decoder.get<String>('name');

    final JsonProperty<String> urlString = decoder.get<String>('url');
    final JsonProperty<Uri> url = (urlString.value?.isNotEmpty ?? false) ? urlString.cast<Uri>((String value) => Uri.tryParse(value)) : null;

    final JsonProperty<String> description = decoder.get<String>('description');

    final JsonProperty<Map<String, dynamic>> creatorMap = decoder.get<Map<String, dynamic>>('creator');
    final JsonProperty<PinCreator> creator = creatorMap.value != null ? creatorMap.cast<PinCreator>((Map<String, dynamic> value) => PinCreator.fromJson(value)) : null;

    final JsonProperty<String> createdAtString = decoder.get<String>('created_at');
    final JsonProperty<DateTime> createdAt = (createdAtString.value?.isNotEmpty ?? false) ? createdAtString.cast<DateTime>((String value) => DateTime.tryParse(value)) : null;

    final JsonProperty<Map<String, dynamic>> countsMap = decoder.get<Map<String, dynamic>>('counts');
    final JsonProperty<PinCounts> counts = countsMap != null ? countsMap.cast<PinCounts>((Map<String, dynamic> value) => PinCounts.fromJson(value)) : null;

    final JsonProperty<Map<String, PinImageCollection>> imageMap = decoder.get<Map<String, PinImageCollection>>('image');
    final JsonProperty<PinImageCollection> image = imageMap.value != null ? imageMap.cast<PinImageCollection>((Map<String, PinImageCollection> value) => PinImageCollection.fromJson(imageMap.value)) : null;

    final JsonProperty<String> privacyString =  decoder.get<String>('privacy');
    final JsonProperty<PinPrivacy> privacy = privacyString != null ? privacyString.cast<PinPrivacy>((String value) => PinPrivacy.fromString(privacyString.value)) : null;

    final JsonProperty<String> reasonString = decoder.get<String>('reason');
    final JsonProperty<PinReason> reason = reasonString != null ? reasonString.cast<PinReason>((String value) => PinReason.fromString(reasonString.value)) : null;

    return BoardInfo._(id, name, url, description, creator, createdAt, counts, image, privacy, reason, rateLimit, rateRemaining);
  }

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('name = $name');
    buffer.writeln('creator = $creator');
    buffer.writeln('url = $url');
    buffer.writeln('createdAt = $createdAt');
    buffer.writeln('privacy = $privacy');
    buffer.writeln('reason = $reason');
    buffer.writeln('image = $image');
    buffer.writeln('counts = $counts');
    buffer.writeln('id = $id');
    buffer.writeln('description = $description');

    return buffer.toString();
  }
}

class PinInfo {
  const PinInfo._();
}

class PinPage {
  final String cursor;
  final Uri next;

  const PinPage._(this.cursor, this.next);

  factory PinPage.fromJson(Map<String, dynamic> json) {
    final cursor = json['cursor'] as String;

    final nextString = json['next'] as String;
    final next = nextString != null ? Uri.tryParse(nextString) : null;
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      this.id.name: this.id.value,
      this.name.name: this.name.value,
      this.url.name: this.url.value,
      this.description.name: this.description.value,
      this.creator.name: this.creator.value,
      this.createdAt.name: this.createdAt.value,
      this.counts.name: this.counts.value,
      this.image.name: this.image.value,
      this.privacy.name: this.privacy.value,
      this.reason.name: this.reason.value
    };

    map.addAll(super.toJson());

    return map;
  }
}

class PinInfo extends PinData {
  final String id;
  final Uri link;
  final Uri url;
  final PinCreator creator;
  final BoardInfo board;
  final DateTime createdAt;
  final String note;
  final String color;
  final PinCounts counts;
  final PinMedia media;
  final PinAttribution attribution;
  final PinImageCollection image;
  final PinMetadata metadata;

  const PinInfo._(
    this.id,
    this.link,
    this.url,
    this.creator,
    this.board,
    this.createdAt,
    this.note,
    this.color,
    this.counts,
    this.media,
    this.attribution,
    this.image,
    this.metadata,
    int rateLimit,
    int rateRemaining
  ) : super._(false, rateLimit, rateRemaining);

  factory PinInfo.fromJson(Map<String, dynamic> json, int rateLimit, int rateRemaining) {
    final String id = json['id'] as String;

    final String linkString = json['link'] as String;
    final Uri link = (linkString?.isNotEmpty ?? false) ? Uri.tryParse(linkString) : null;

    final String urlString = json['url'] as String;
    final Uri url = (urlString?.isNotEmpty ?? false) ? Uri.tryParse(urlString) : null;

  factory PinCreator.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    final urlString = json['uri'] as String;
    final url = urlString != null ? Uri.tryParse(urlString) : null;

    final firstName = json['firstName'] as String;
    final lastName = json['lastName'] as String;
    final id = json['id'] as String;
    final Map<String, String> creatorMap = json['creator'] as Map<String, String>;
    final PinCreator creator = creatorMap != null ? PinCreator.fromJson(creatorMap) : null;

    return null;
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

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final username = json['username'] as String;
    final bio = json['bio'] as String;
    final firstName = json['first_name'] as String;
    final lastName = json['last_name'] as String;
    final accountType = json['account_type'] as String;
  factory UserInfo.fromJson(Map<String, dynamic> json, int rateLimit, int rateRemaining) {
    final String username = json['username'] as String;
    final String bio = json['bio'] as String;
    final String firstName = json['first_name'] as String;
    final String lastName = json['last_name'] as String;
    final String accountType = json['account_type'] as String;

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
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{
      'username': this.username,
      'bio': this.bio,
      'first_name': this.firstName,
      'last_name': this.lastName,
      'account_type': this.accountType,
      'url': this.url,
      'created_at': this.createdAt,
      'image': this.image.toJson(),
      'counts': this.counts.toJson(),
      'id': this.id
    };

    map.addAll(super.toJson());

    return map;
  }
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
    final String urlString = json['uri'] as String;
    final Uri url = urlString != null ? Uri.tryParse(urlString) : null;

    final String firstName = json['firstName'] as String;
    final String lastName = json['lastName'] as String;
    final String id = json['id'] as String;

    return PinCreator._(url, firstName, lastName, id);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': this.url,
    'firstName': this.firstName,
    'lastName': this.lastName,
    'id': this.id
  };

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('url = ${this.url}');
    buffer.writeln('firstName = ${this.firstName}');
    buffer.writeln('lastName = ${this.lastName}');
    buffer.writeln('id = ${this.id}');

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
    final int pins = json['pins'] as int;
    final int collaborators = json['collaborators'] as int;
    final int followers = json['followers'] as int;

  factory PinPrivacy.fromString(String value) {
    if (value == null) return null;
    switch (value) {
      case 'public': return PUBLIC;
      case 'private': return PRIVATE;
      default: return null;
    }
    return PinCounts._(pins, collaborators, followers);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'pins': this.pins,
    'collaborators': this.collaborators,
    'followers': this.followers
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
    final String urlString = json['url'] as String;
    final Uri uri = urlString != null ? Uri.tryParse(urlString) : null;

    final int width = json['width'] as int;
    final int height = json['height'] as int;

    return PinImage._(uri, width, height);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'url': this.url,
    'width': this.width,
    'height': this.height
  };

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

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
    if (json == null) return null;
    final collection = List<PinImage>(json.keys.length);

    var i = 0;
    for (final key in json.keys) {
      collection[i++] = PinImage.fromJson(json[key]);
    }
    json.keys.forEach((String key) => collection.add(PinImage.fromJson(json[key])));

    return PinImageCollection._(collection);
  }

  PinImage operator [](int index) => _collection[index];

  bool get isEmpty => _collection.isEmpty;
  bool get isNotEmpty => _collection.isNotEmpty;

  PinImage get first => _collection[0];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map<String, dynamic>();

    return map;
  }

  @override
  String toString() => _collection.toString();
}

class PinMedia {
  final JsonProperty<PinMediaType> type;

  const PinMedia._(this.type);

  factory PinImage.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    final urlString = json['url'] as String;
    final uri = urlString != null ? Uri.tryParse(urlString) : null;

    final width = json['width'] as int;
    final height = json['height'] as int;
  factory PinMedia.fromJson(Map<String, String> json) {
    final JsonDecoder decoder = JsonDecoder(json);

    final JsonProperty<String> typeString = decoder.get<String>('type');
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
    final JsonDecoder decoder = JsonDecoder(json);

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
    final String cursor = json['cursor'] as String;

    final String nextString = json['next'] as String;
    final Uri next = nextString != null ? Uri.tryParse(nextString) : null;

    return PinPage._(cursor, next);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'cursor': this.cursor,
    'next': this.next
  };

  @override
  String toString() {
    final buffer = StringBuffer();

    buffer.writeln('cursor = ${this.cursor}');
    buffer.writeln('next = ${this.next}');

    return buffer.toString();
  }
}

class PinPrivacy {
  static const PinPrivacy PUBLIC = PinPrivacy._('public');
  static const PinPrivacy PRIVATE = PinPrivacy._('private');

  final String privacy;

  factory PinCounts.fromJson(Map<String, dynamic> json) {
    final pins = json['pins'] as int;
    final collaborators = json['collaborators'] as int;
    final followers = json['followers'] as int;
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
    'privacy': this.privacy
  };

  @override
  String toString() => this.privacy;
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
    'reason': this.reason
  };

  @override
  String toString() => this.reason;
}
