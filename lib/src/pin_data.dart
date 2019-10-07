class PinResult<T> {
  final T successData;
  final PinErrorData errorData;
  final bool errorOccured;
  final bool isResultEmpty;

  const PinResult._(this.successData, this.errorData, this.errorOccured, this.isResultEmpty);

  factory PinResult({T successData, PinErrorData errorData}) {
    if (successData == null && errorData == null) {
      return PinResult._(null, null, true, true);
    } else {
      return PinResult._(successData, errorData, errorData != null, false);
    }
  }
  factory PinResult.empty() => PinResult._(null, null, true, true);
}

class PinData {
  final bool errorOccured;
  final int rateLimit;
  final int rateRemaining;

  const PinData._(this.errorOccured, this.rateLimit, this.rateRemaining);
}

class PinErrorData extends PinData {
  final String status;
  final String message;
  final int code;
  final dynamic data;
  final String type;
  final int statusCode;

  const PinErrorData._(this.status, this.message, this.code, this.data, this.type, this.statusCode, [int rateLimit, int rateRemaining]) : super._(true, rateLimit, rateRemaining);

  factory PinErrorData.fromJson(Map<String, dynamic> json, int statusCode, [int rateLimit, int rateRemaining]) {
    final String status = json['status'] as String;
    final String message = json['message'] as String;
    final int code = json['code'] as int;
    final dynamic data = json['data'];
    final String type = json['type'] as String;

    return PinErrorData._(status, message, code, data, type, statusCode, rateLimit, rateRemaining);
  }
}

class PinRootData extends PinData {
  final dynamic data;
  final bool isDataListType;

  const PinRootData._(this.data, this.isDataListType, [int rateLimit, int rateRemaining]) : super._(false, rateLimit, rateRemaining);

  factory PinRootData.fromJson(Map<String, dynamic> json, [int rateLimit, int rateRemaining]) {
    final dynamic data = json['data'];
    final bool isDataListType = data is List;

    return PinRootData._(data, isDataListType, rateLimit, rateRemaining);
  }
}

class SectionInfo {
  const SectionInfo._();
}

class BoardInfo {
  final String name;
  final PinCreator creator;
  final Uri url;
  final DateTime createdAt;
  final PinPrivacy privacy;
  final PinReason reason;
  final PinImageCollection image;
  final PinCounts counts;
  final String id;
  final String description;

  const BoardInfo._(
    this.name,
    this.creator,
    this.url,
    this.createdAt,
    this.privacy,
    this.reason,
    this.image,
    this.counts,
    this.id,
    this.description
  );

  factory BoardInfo.fromJson(Map<String, dynamic> json) {
    final String name = json['name'] as String;

    final Map<String, dynamic> creatorMap = json['creator'] as Map<String, dynamic>;
    final PinCreator creator = creatorMap != null ? PinCreator.fromJson(creatorMap) : null;

    final String urlString = json['url'] as String;
    final Uri url = urlString != null ? Uri.tryParse(urlString) : null;

    final String createdAtString = json['created_at'] as String;
    final DateTime createdAt = createdAtString != null ? DateTime.tryParse(createdAtString) : null;

    final String privacyString = json['privacy'] as String;
    final PinPrivacy privacy = privacyString != null ? PinPrivacy.fromString(privacyString) : null;

    final String reasonString = json['reason'] as String;
    final PinReason reason = reasonString != null ? PinReason.fromString(reasonString) : null;

    final Map<String, dynamic> imageMap = json['image'] as Map<String, dynamic>;
    final PinImageCollection image = imageMap != null ? PinImageCollection.fromJson(imageMap) : null;

    final Map<String, dynamic> countsMap = json['counts'] as Map<String, dynamic>;
    final PinCounts counts = countsMap != null ? PinCounts.fromJson(countsMap) : null;

    final String id = json['id'] as String;
    final String description = json['description'] as String;

    return BoardInfo._(description, creator, url, createdAt, privacy, reason, image, counts, id, name);
  }

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

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
    final String cursor = json['cursor'] as String;

    final String nextString = json['next'] as String;
    final Uri next = nextString != null ? Uri.tryParse(nextString) : null;

    return PinPage._(cursor, next);
  }
}

class PinCreator {
  final Uri url;
  final String firstName;
  final String lastName;
  final String id;

  const PinCreator._(this.url, this.firstName, this.lastName, this.id);

  factory PinCreator.fromJson(Map<String, dynamic> json) {
    final String urlString = json['uri'] as String;
    final Uri url = urlString != null ? Uri.tryParse(urlString) : null;

    final String firstName = json['firstName'] as String;
    final String lastName = json['lastName'] as String;
    final String id = json['id'] as String;

    return PinCreator._(url, firstName, lastName, id);
  }
}

class UserInfo {
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
    this.id
  );

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    final String username = json['username'] as String;
    final String bio = json['bio'] as String;
    final String firstName = json['first_name'] as String;
    final String lastName = json['last_name'] as String;
    final String accountType = json['account_type'] as String;

    final String urlString = json['url'] as String;
    final Uri url = urlString != null ? Uri.tryParse(urlString) : null;

    final String createdAtString = json['createdAt'] as String;
    final DateTime createdAt = createdAtString != null ? DateTime.tryParse(createdAtString) : null;

    final PinImageCollection image = PinImageCollection.fromJson(json['image']);
    final PinCounts counts = PinCounts.fromJson(json['counts']);

    final String id = json['id'] as String;

    return UserInfo._(username, bio, firstName, lastName, accountType, url, createdAt, image, counts, id);
  }

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('username = $username');
    buffer.writeln('bio = $bio');
    buffer.writeln('firstName = $firstName');
    buffer.writeln('lastName = $lastName');
    buffer.writeln('accountType = $accountType');
    buffer.writeln('url = $url');
    buffer.writeln('createdAt = $createdAt');
    buffer.writeln('id = $id');

    return buffer.toString();
  }
}

class PinPrivacy {
  static const PinPrivacy PUBLIC = PinPrivacy._('public');
  static const PinPrivacy PRIVATE = PinPrivacy._('private');

  final String value;

  const PinPrivacy._(this.value);

  factory PinPrivacy.fromString(String value) {
    switch (value) {
      case 'public': return PUBLIC;
      case 'private': return PRIVATE;
      default: return null;
    }
  }
}

class PinReason {
  static const PinReason RECENTLY_PICKED = PinReason._('Recently picked');

  final String value;

  const PinReason._(this.value);

  factory PinReason.fromString(String value) {
    switch (value) {
      case 'Recently picked': return RECENTLY_PICKED;
      default: return null;
    }
  }
}

class PinImageCollection {
  final List<PinImage> _collection;

  const PinImageCollection._(this._collection);

  factory PinImageCollection.fromJson(Map<String, dynamic> json) {
    final List<PinImage> collection = List<PinImage>(json.keys.length);

    int i = 0;
    json.keys.forEach((String key) => collection[i++] = PinImage.fromJson(json[key]));

    return PinImageCollection._(collection);
  }

  PinImage operator [](int index) => this._collection[index];

  bool get isEmpty => this._collection.isEmpty;
  bool get isNotEmpty => this._collection.isNotEmpty;

  PinImage get first => this._collection[0];

  @override
  String toString() => this._collection.toString();
}

class PinImage {
  final Uri url;
  final int width;
  final int height;

  const PinImage._(this.url, this.width, this.height);

  factory PinImage.fromJson(Map<String, dynamic> json) {
    final String urlString = json['url'] as String;
    final Uri uri = urlString != null ? Uri.tryParse(urlString) : null;

    final int width = json['width'] as int;
    final int height = json['height'] as int;

    return PinImage._(uri, width, height);
  }

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

    buffer.writeln('url = $url');
    buffer.writeln('width = $width');
    buffer.writeln('height = $height');

    return buffer.toString();
  }
}

class PinCounts {
  final int pins;
  final int collaborators;
  final int followers;

  const PinCounts._(this.pins, this.collaborators, this.followers);

  factory PinCounts.fromJson(Map<String, dynamic> json) {
    final int pins = json['pins'] as int;
    final int collaborators = json['collaborators'] as int;
    final int followers = json['followers'] as int;

    return PinCounts._(pins, collaborators, followers);
  }
}
