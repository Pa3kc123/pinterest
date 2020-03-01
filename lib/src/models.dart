import '../tools/annotations.dart';
import 'util.dart';

@JsonData('Map<String, dynamic>')
class PinterestMessage<T> {
  @CastableJsonProperty('status')
  String _status;
  @CastableJsonProperty('code')
  int _code;
  @CastableJsonProperty('data')
  T _data;
  @CastableJsonProperty('message')
  String _message;
  @CastableJsonProperty('type')
  String _type;
}

@JsonData('Map<String, dynamic>')
class SectionInfo {
  @CastableJsonProperty('id')
  String _id;
}

@JsonData('Map<String, dynamic>')
class BoardInfo {
  @CastableJsonProperty('id')
  String _id;
  @CastableJsonProperty('name')
  String _name;
  @ParseableJsonProperty('url', 'String', 'Uri.tryParse(value)')
  Uri _url;
  @CastableJsonProperty('description')
  String _description;
  @ParseableJsonProperty('creator', 'Map<String, dynamic>', 'PinCreator()..decode(value)')
  PinCreator _creator;
  @ParseableJsonProperty('created_at', 'String', 'DateTime.tryParse(value)')
  DateTime _createdAt;
  @ParseableJsonProperty('counts', 'Map<String, dynamic>', 'PinCounts()..decode(value)')
  PinCounts _counts;
  // @ParseableJsonProperty('image', 'Map<String, dynamic>', 'PinImageCollection()..decode(value)')
  // PinImageCollection _image;
  @ParseableJsonProperty('privacy', 'String', 'PinPrivacy()..decode(value)')
  PinPrivacy _privacy;
  @ParseableJsonProperty('reason', 'String', 'PinReason()..decode(value)')
  PinReason _reason;
}

@JsonData('Map<String, dynamic>')
class PinInfo {
  @CastableJsonProperty('id')
  String _id;
  @ParseableJsonProperty('link', 'String', 'Uri.tryParse(value)')
  Uri _link;
  @ParseableJsonProperty('url', 'String', 'Uri.tryParse(value)')
  Uri _url;
  @ParseableJsonProperty('creator', 'Map<String, dynamic>', 'PinCreator()..decode(value)')
  PinCreator _creator;
  @ParseableJsonProperty('board', 'Map<String, dynamic>', 'BoardInfo()..decode(value)')
  BoardInfo _board;
  @ParseableJsonProperty('created_at', 'String', 'DateTime.tryParse(value)')
  DateTime _createdAt;
  @CastableJsonProperty('note')
  String _note;
  @CastableJsonProperty('color')
  String _color;
  @ParseableJsonProperty('counts', 'Map<String, dynamic>', 'PinCounts()..decode(value)')
  PinCounts _counts;
  @ParseableJsonProperty('media', 'Map<String, dynamic>', 'PinMedia()..decode(value)')
  PinMedia _media;
  @ParseableJsonProperty('attribution', 'Map<String, dynamic>', 'PinAttribution()..decode(value)')
  PinAttribution _attribution;
  // @ParseableJsonProperty('image', 'Map<String, dynamic>', 'PinImageCollection()..decode(value)')
  // PinImageCollection _image;
  @ParseableJsonProperty('metadata', 'Map<String, dynamic>', 'PinMetadata()..decode(value)')
  PinMetadata _metadata;
}

@JsonData('Map<String, dynamic>')
class UserInfo {
  @CastableJsonProperty('username')
  String _username;
  @CastableJsonProperty('bio')
  String _bio;
  @CastableJsonProperty('first_name')
  String _firstName;
  @CastableJsonProperty('last_name')
  String _lastName;
  @CastableJsonProperty('account_type')
  String _accountType;
  @ParseableJsonProperty('url', 'String', 'Uri.tryParse(value)')
  Uri _url;
  @ParseableJsonProperty('created_at', 'String', 'DateTime.tryParse(value)')
  DateTime _createdAt;
  // @ParseableJsonProperty('image', 'Map<String, dynamic>', 'PinImageCollection()..decode(value)')
  // PinImageCollection _image;
  @ParseableJsonProperty('counts', 'Map<String, dynamic>', 'PinCounts()..decode(value)')
  PinCounts _counts;
  @CastableJsonProperty('id')
  String _id;
}

@JsonData('dynamic')
class PinAttribution {
  @CastableJsonProperty('value')
  dynamic _value;
}

@JsonData('Map<String, dynamic>')
class PinCreator {
  @ParseableJsonProperty('url', 'String', 'Uri.tryParse(value)')
  Uri _url;
  @CastableJsonProperty('first_name')
  String _firstName;
  @CastableJsonProperty('last_name')
  String _lastName;
  @CastableJsonProperty('id')
  String _id;
}

@JsonData('Map<String, dynamic>')
class PinCounts {
  @CastableJsonProperty('pins')
  int _pins;
  @CastableJsonProperty('collaborators')
  int _collaborators;
  @CastableJsonProperty('followers')
  int _followers;
}

@JsonData('Map<String, dynamic>')
class PinImage {
  @ParseableJsonProperty('url', 'String', 'Uri.tryParse(value)')
  Uri _url;
  @CastableJsonProperty('width')
  int _width;
  @CastableJsonProperty('height')
  int _height;
}

// @JsonData('Map<String, dynamic>')
// class PinImageCollection {
//   List<PinImage> _collection;

//   PinImageCollection([
//     this._collection
//   ]);

//   @override
//   void decode(Map<String, dynamic> json) {
//     if (json == null) return null;

//     final decoder = JsonDecoder(json);
//     _collection = List<PinImage>>(json.keys.lengh);

//     var i = 0;
//     for (final key in json.keys) {
//       _collection[i] = decoder.getAndParse<Map<String, dynamic>, PinImage>(key, (Map<String, dynamic> value) => PinImage()..decode(value));
//     }
//   }

//   PinImage operator [](int index) => _collection[index]?.value;

//   bool get isEmpty => _collection?.isEmpty ?? false;
//   bool get isNotEmpty => _collection?.isNotEmpty ?? false;

//   PinImage get first => _collection[0]?.value;

//   @override
//   Map<String, dynamic> encode() => encodeValues(_collection);
// }

@JsonData('Map<String, dynamic>')
class PinMedia {
  @ParseableJsonProperty('type', 'String', 'PinMediaType()..decode(value)')
  PinMediaType _type;
}

@JsonData('String')
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

@JsonData('Map<String, dynamic>')
class PinMetadata {
  @ParseableJsonProperty('link', 'Map<String, dynamic>', 'PinMetadataLink()..decode(value)')
  PinMetadataLink _link;
}

@JsonData('Map<String, dynamic>')
class PinMetadataLink {
}

@JsonData('Map<String, dynamic>')
class PinPage {
  @CastableJsonProperty('cursor')
  String _cursor;
  @ParseableJsonProperty('url', 'String', 'Uri.tryParse(value)')
  Uri _next;

}

@JsonData('String')
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

@JsonData('String')
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
