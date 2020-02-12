import 'dart:convert';
import 'dart:io';

import 'package:pinterest/pinterest.dart';
import 'package:pinterest/src/fields.dart';
import 'package:pinterest/src/functions.dart';
import 'package:pinterest/src/util.dart';

const String TOKEN_TYPE = 'bearer';

const String PINTEREST_HOSTNAME = 'api.pinterest.com';
const int PINTEREST_API_VERSION = 1;
String _accessToken;
bool _requestAllFields = false;

const String READ_WRITE_ALL = 'read_write_all';
//Use GET method on a user’s Pins, boards.
const String SCOPE_READ_PUBLIC = 'read_public';
//Use PATCH, POST and DELETE methods on a user’s Pins and boards.
const String SCOPE_WRITE_PUBLIC = 'write_public';
//Use GET method on a user’s follows and followers (on boards, users and interests).
const String SCOPE_READ_RELATIONSHIPS = 'read_relationships';
//Use PATCH, POST and DELETE methods on a user’s follows and followers (on boards, users and interests).
const String SCOPE_WRITE_RELATIONSHIPS = 'write_relationships';

class MiniObject {
  final int rateLimit;
  final int rateRemaining;
  final int statusCode;
  final Map<String, dynamic> json;

  const MiniObject(this.rateLimit, this.rateRemaining, this.statusCode, this.json);
}

Future<MiniObject> _getSiteData(String path, [List<FieldData> fields, int limit]) async {
  if (_accessToken == null) throw StateError('You need to set access token first');

  final _fields = <String, String>{
    'access_token': _accessToken,
    if (fields != null) 'fields': fields.join(','),
    if (limit != null) 'limit': limit.toString()
  };

  final uri = Uri.https(PINTEREST_HOSTNAME, '/v$PINTEREST_API_VERSION$path', _fields);
  final client = HttpClient();

  HttpClientResponse response;
  try {
    response = await (await client.getUrl(uri))?.close();
  } on SocketException {
    rethrow;
  } finally {
    client?.close();
  }

  final rateLimitString = response.headers.value('X-Ratelimit-Limit');
  final rateLimit = rateLimitString != null ? int.parse(rateLimitString) : null;

  final rateRemainingString = response.headers.value('X-Ratelimit-Remaining');
  final rateRemaining = rateRemainingString != null ? int.parse(rateRemainingString) : null;

  final responseBody = await response.transform(const Utf8Decoder()).join();
  final json = jsonDecode(responseBody);

  return MiniObject(rateLimit, rateRemaining, response.statusCode, json);
}

Future<PinterestMessage> getJsonPinData(String path, [List<FieldData> fields, int limit]) async {
  MiniObject obj;

  try {
    obj = await _getSiteData(path, fields, limit);
  } on StateError {
    rethrow;
  }

  if (obj?.json == null) return null;

  return PinterestMessage()..decode(obj.json);
}

Future<List<PinData>> getJsonPinDataList<T extends PinData>(String path, [List<FieldData> fields, int limit]) async {
  MiniObject obj;

  try {
    obj = await _getSiteData(path, fields, limit);
  } on StateError {
    rethrow;
  }

  if (obj.json == null) return null;

  if (obj.statusCode != HttpStatus.ok) {
    throw PinDataError()
      ..status = obj.json['status'] as String
      ..message = obj.json['message'] as String
      ..code = obj.json['code'] as int
      ..data = obj.json['data'] as dynamic
      ..type = obj.json['type'] as String
      ..statusCode = obj.statusCode
      ..rateLimit = obj.rateLimit
      ..rateRemaining = obj.rateRemaining;
  }

  return generateListType<T>(obj.json.keys.length)
    ..forEach((T value) => generateType<T>()
      ..decode(obj.json)
      ..rateLimit = obj.rateLimit
      ..rateRemaining = obj.rateRemaining
    );
}

Future<PinData> getFakeJsonPinData<T extends PinData>(String path) async {
  MiniObject obj = MiniObject(-1, -1, 200, jsonDecode(await File(path).readAsString()));

  if (obj.json == null) return null;

  if (obj.statusCode == HttpStatus.ok) {
    T type = generateType<T>();

    if (type == null) return null;

    return type
      ..decode(obj.json['data'])
      ..rateLimit = obj.rateLimit
      ..rateRemaining = obj.rateRemaining;
  } else {
    return generateType<PinErrorData>()
      ..decode(obj.json)
      ..statusCode = obj.statusCode
      ..rateLimit = obj.rateLimit
      ..rateRemaining = obj.rateRemaining;
  }
}

/*Future<PinData> postJsonPinData(String path, Map<String, dynamic> data, [List<FieldData> fields]) async {
  if (_accessToken == null) throw StateError('You need to set access token first');

  final Map<String, String> _fields = <String, String>{
    'access_token': _accessToken,
    if (fields != null) 'fields': fields.join(',')
  };

  final Uri uri = Uri.https(PINTEREST_HOSTNAME, '/v$PINTEREST_API_VERSION$path', _fields);
  final HttpClient client = HttpClient();

  HttpClientResponse response;
  try {
    final HttpClientRequest request = await client.postUrl(uri);
    request.write(data);
    response = await request.close();
  } on SocketException {
    rethrow;
  } finally {
    client?.close();
  }

  final String rateLimitString = response.headers.value('X-Ratelimit-Limit');
  final int rateLimit = rateLimitString != null ? int.parse(rateLimitString) : null;

  final String rateRemainingString = response.headers.value('X-Ratelimit-Remaining');
  final int rateRemaining = rateRemainingString != null ? int.parse(rateRemainingString) : null;

  final String responseBody = await response.transform(utf8.decoder).join();
  final Map<String, dynamic> json = jsonDecode(responseBody);

  if (json == null) return null;

  return response.statusCode == HttpStatus.ok ? PinData.fromJson(json, rateLimit, rateRemaining) : PinErrorData.fromJson(json, response.statusCode, rateLimit, rateRemaining);
}*/

Section get section => Section();
Board get board => Board();
Me get me => Me();
Pin get pin => Pin();
User get user => User();

String get accessToken => _accessToken;
bool get requestAllFields => _requestAllFields;

set accessToken(String value) => _accessToken = value;
set requestAllFields(bool value) => _requestAllFields = value ?? _requestAllFields;