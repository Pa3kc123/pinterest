import 'dart:convert';
import 'dart:io';

import 'fields.dart';
import 'functions.dart';
import 'util.dart';

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

class ResponseData {
  final int rateLimit;
  final int rateRemaining;
  final int statusCode;
  final Map<String, dynamic> json;

  const ResponseData(this.rateLimit, this.rateRemaining, this.statusCode, this.json);
}

Future<HttpClientResponse> _getFromApi(final Uri url) async {
  if (url == null) return null;

  final client = HttpClient();

  HttpClientRequest request;
  HttpClientResponse response;
  try {
    request = await client.getUrl(url);
    response = await request?.close();

    if (response.statusCode == HttpStatus.permanentRedirect) {
      final redirectUrlString = response.headers.value('Location');
      if (redirectUrlString != null) {
        final _url = Uri.tryParse(redirectUrlString);
        return _getFromApi(_url);
      }
    }

    return response;
  } catch (e) {
    print(e);
    rethrow;
  } finally {
    client?.close();
  }
}

Future<HttpClientResponse> _postToApi(final Uri url) async {
  if (url == null) return null;

  final client = HttpClient();

  HttpClientRequest request;
  HttpClientResponse response;
  try {
    request = await client.postUrl(url);


    response = await request?.close();

    if (response.statusCode == HttpStatus.permanentRedirect) {
      final redirectUrlString = response.headers.value('Location');
      if (redirectUrlString != null) {
        final _url = Uri.tryParse(redirectUrlString);
        return _getFromApi(_url);
      }
    }

    return response;
  } catch (e) {
    print(e);
    rethrow;
  } finally {
    client?.close();
  }
}

Future<ResponseData> _getSiteData(String path, [List<FieldData> fields, int limit]) async {
  if (_accessToken == null) throw StateError('You need to set access token first');

  final _fields = <String, String>{
    'access_token': _accessToken,
    if (fields != null) 'fields': fields.join(','),
    if (limit != null) 'limit': limit.toString()
  };

  final url = Uri.https(PINTEREST_HOSTNAME, '/v$PINTEREST_API_VERSION$path', _fields);
  final response = await _getFromApi(url);

  final responseBody = await response?.transform(const Utf8Decoder())?.join();

  if (response.statusCode != HttpStatus.ok) {
    switch (response.statusCode) {
      default:
        throw PinException(ResponseData(-1, -1, response.statusCode, null), responseBody);
      break;
    }
  }

  int rateLimit, rateRemaining;
  {
    final headerDecoder = HttpHeaderDecoder(response.headers);

    rateLimit = headerDecoder.getAndParse<int>('X-Ratelimit-Limit', (String value) => int.parse(value));
    rateRemaining = headerDecoder.getAndParse<int>('X-Ratelimit-Remaining', (String value) => int.parse(value));
  }

  final json = jsonDecode(responseBody) as Map<String, dynamic>;

  return ResponseData(rateLimit, rateRemaining, response.statusCode, json);
}

Future<ResponseData> _postSiteData(String path, [List<FieldData> fields, int limit]) async {
  if (_accessToken == null) throw StateError('You need to set access token first');

  final _fields = <String, String>{
    'access_token': _accessToken,
    if (fields != null) 'fields': fields.join(','),
    if (limit != null) 'limit': limit.toString()
  };

  final url = Uri.https(PINTEREST_HOSTNAME, '/v$PINTEREST_API_VERSION$path', _fields);
  // final response = _postToApi(url);
  final _ = _postToApi(url);

  return Future.value(null);
}

Future<ResponseData> getJsonPinData(IPath path, {
  List<FieldData> fields,
  int limit,
  List<String> extraArgs
}) async {
  if (extraArgs?.isEmpty ?? true && extraArgs.first == null) {
    return Future.value(null);
  }

  try {
    return await _getSiteData(path.path, fields, limit);
  } catch(e) {
    rethrow;
  }
}

Future<ResponseData> postJsonPinData(IPath path, [List<FieldData> fields, int limit]) async {
  try {
    return await _postSiteData(path.path, fields, limit);
  } catch(e) {
    rethrow;
  }
}

Section get section => Section();
Board get board => Board();
Me get me => Me();
Pin get pin => Pin();
User get user => User();

String get accessToken => _accessToken;
bool get requestAllFields => _requestAllFields;

set accessToken(String value) => _accessToken = value;
set requestAllFields(bool value) => _requestAllFields = (value ?? _requestAllFields);
