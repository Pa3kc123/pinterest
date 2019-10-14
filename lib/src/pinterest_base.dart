import 'dart:convert';
import 'dart:io';

import 'package:pinterest/src/fields.dart';
import 'package:pinterest/src/pin_data.dart';
import 'package:pinterest/src/pin_func.dart';

const String TOKEN_TYPE = 'bearer';

const String PINTEREST_HOSTNAME = 'api.pinterest.com';
const int PINTEREST_API_VERSION = 1;
String _accessToken;

const String READ_WRITE_ALL = 'read_write_all';
//Use GET method on a user’s Pins, boards.
const String SCOPE_READ_PUBLIC = 'read_public';
//Use PATCH, POST and DELETE methods on a user’s Pins and boards.
const String SCOPE_WRITE_PUBLIC = 'write_public';
//Use GET method on a user’s follows and followers (on boards, users and interests).
const String SCOPE_READ_RELATIONSHIPS = 'read_relationships';
//Use PATCH, POST and DELETE methods on a user’s follows and followers (on boards, users and interests).
const String SCOPE_WRITE_RELATIONSHIPS = 'write_relationships';

Future<PinData> getJsonPinData(String path, [List<FieldData> fields, int limit]) async {
  if (_accessToken == null) throw StateError('You need to set access token first');

  final Map<String, String> _fields = <String, String>{
    'access_token': _accessToken,
    if (fields != null) 'fields': fields.join(','),
    if (limit != null) 'limit': limit.toString()
  };

  final Uri uri = Uri.https(PINTEREST_HOSTNAME, '/v$PINTEREST_API_VERSION$path', _fields);
  final HttpClient client = HttpClient();

  HttpClientResponse response;
  try {
    final HttpClientRequest request = await client.getUrl(uri);
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

  final String responseBody = await response.transform(const Utf8Decoder()).join();
  final Map<String, dynamic> json = jsonDecode(responseBody);

  if (json == null) return null;

  return response.statusCode == HttpStatus.ok ? PinRootData.fromJson(json, rateLimit, rateRemaining) : PinErrorData.fromJson(json, response.statusCode, rateLimit, rateRemaining);
}

Future<bool> postJsonPinData(String path) async {
  if (_accessToken == null) throw StateError('You need to set access token first');

  final Map<String, String> _fields = <String, String>{
    'access_token': _accessToken
  };

  final Uri uri = Uri.https(PINTEREST_HOSTNAME, '/v$PINTEREST_API_VERSION$path', _fields);
  final HttpClient client = HttpClient();

  HttpClientResponse response;
  try {
    final HttpClientRequest request = await client.postUrl(uri);
    response = await request.close();
  } on SocketException {
    rethrow;
  } finally {
    client?.close();
  }

  return null;
}

Section get section => Section();
Board get board => Board();
Me get me => Me();
Pin get pin => Pin();
User get user => User();

set accessToken(String value) => _accessToken = value;
