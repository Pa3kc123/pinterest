import 'dart:io' show HttpStatus;

class GeneralError extends Iterable {
  static const GeneralError BAD_REQUEST = GeneralError._(HttpStatus.badRequest);
  static const GeneralError UNAUTHORIZED = GeneralError._(HttpStatus.unauthorized);
  static const GeneralError NOT_FOUND = GeneralError._(HttpStatus.notFound);
  static const GeneralError TIME_OUT = GeneralError._(HttpStatus.requestTimeout);
  static const GeneralError TOO_MANY_REQUESTS = GeneralError._(HttpStatus.tooManyRequests);
  static const GeneralError SERVER_ERROR_INTERNAL_SERVER_ERROR = GeneralError._(HttpStatus.internalServerError);
  static const GeneralError SERVER_ERROR_BAD_GATEWAY = GeneralError._(HttpStatus.badGateway);
  static const GeneralError SERVER_ERROR_NETWORK_CONNECTION_TIMEOUT_ERROR = GeneralError._(HttpStatus.networkConnectTimeoutError);

  final int code;

  const GeneralError._(this.code);

  List<GeneralError> get values => <GeneralError>[
    BAD_REQUEST,
    UNAUTHORIZED,
    NOT_FOUND,
    TIME_OUT,
    TOO_MANY_REQUESTS,
    SERVER_ERROR_INTERNAL_SERVER_ERROR,
    SERVER_ERROR_BAD_GATEWAY,
    SERVER_ERROR_NETWORK_CONNECTION_TIMEOUT_ERROR
  ];

  @override
  Iterator get iterator => values.iterator;

  @override
  bool operator ==(dynamic val) => val is GeneralError && val.code == code;
}

class OAuthError extends GeneralError {
  const OAuthError._(int code) : super._(code);
}

class UserError extends GeneralError {
  static const UserError PERMISION = UserError._(HttpStatus.forbidden);

  const UserError._(int code) : super._(code);

  @override
  List<UserError> get values => super.values..add(PERMISION);
}

class BoardError extends GeneralError {
  static const BoardError METHOD_NOT_ALLOWED = BoardError._(HttpStatus.methodNotAllowed);

  const BoardError._(int code) : super._(code);

  @override
  List<BoardError> get values => super.values..add(METHOD_NOT_ALLOWED);
}

class PinError extends GeneralError {
  static const PinError PERMISION = PinError._(HttpStatus.forbidden);

  const PinError._(int code) : super._(code);

  @override
  List<PinError> get values => super.values..add(PERMISION);
}
