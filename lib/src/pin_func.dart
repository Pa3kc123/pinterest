import 'package:pinterest/src/fields.dart';
import 'package:pinterest/src/pinterest_base.dart';
import 'package:pinterest/src/pin_data.dart';
import 'package:pinterest/src/pin_filters.dart';
import 'package:pinterest/src/pin_paths.dart';

class Section {
  static const Section _inst = Section._();

  const Section._();

  factory Section() => _inst;

  bool createSection(BoardInfo board, String title, [List<PinInfo> initialPins]) => throw UnsupportedError('Not yet implemented');
  Future<PinResult<List<SectionInfo>>> getSectionsFromBoard(BoardInfo board, [String cursor]) async {
    final PinData pinData = await getJsonPinData(null);

    if (pinData != null) {
      if (pinData.errorOccured) {
        return PinResult(
          errorData: pinData as PinErrorData
        );
      } else {
        final PinRootData pinRootData = pinData as PinRootData;
        return PinResult(
          successData: List<SectionInfo>.generate(pinRootData.data.length, (int index) => SectionInfo.fromString(pinRootData.data[index]))
        );
      }
    } else {
      return PinResult.empty();
    }
  }
  bool removeSection(SectionInfo section) => throw UnsupportedError('Not yet implemented');
  List<PinInfo> getPinsFromSection(SectionInfo section, [String cursor]) => throw UnsupportedError('Not yet implemented');
}

class Board {
  static const Board _inst = Board._();

  const Board._();

  factory Board() => _inst;

  bool createBoard(String name, {
    String description,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');
  bool removeBoard(BoardInfo board) => throw UnsupportedError('Not yet implemented');
  bool editBoard(BoardInfo board, {
    String name,
    String description,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');
  BoardInfo getBoardInfo(BoardInfo board, [List<FieldData> fields]) => throw UnsupportedError('Not yet implemented');
  List<PinInfo> getPinsFromBoard(BoardInfo board, {
    String cursor,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');
}

class Me {
  static const Me _inst = Me._();

  const Me._();

  factory Me() => _inst;

  ///Return the logged in user's information
  Future<PinResult<UserInfo>> getMyInfo([List<FieldData> fields]) async {
    filterFields(ME_GET_MY_INFO_CODE, fields);

    final PinData pinData = await getJsonPinData(PATH_ME, fields);

    if (pinData != null) {
      if (pinData.errorOccured) {
        return PinResult(
          errorData: pinData as PinErrorData
        );
      } else {
        return PinResult(
          successData: UserInfo.fromJson((pinData as PinRootData).data)
        );
      }
    } else {
      return PinResult.empty();
    }
  }

  ///Return the logged in user's Boards
  Future<PinResult<List<BoardInfo>>> getMyBoards([List<FieldData> fields, int limit]) async {
    filterFields(ME_GET_MY_BOARDS_CODE, fields);

    final PinData pinData = await getJsonPinData(PATH_ME_BOARDS, fields);

    if (pinData != null) {
      if (pinData.errorOccured) {
        return PinResult(
          errorData: pinData as PinErrorData
        );
      } else {
        final PinRootData pinRootData = pinData as PinRootData;
        return PinResult(
          successData: List<BoardInfo>.generate(pinRootData.data.length, (int index) => BoardInfo.fromJson(pinRootData.data[index]))
        );
      }
    } else {
      return PinResult.empty();
    }
  }

  ///Return Board suggestions for the logged in user
  Future<PinResult<List<BoardInfo>>> getMySuggestion({int count, PinInfo pin, List<FieldData> fields}) async {
    filterFields(ME_GET_MY_SUGGESTION_CODE, fields);

    final PinData pinData = await getJsonPinData(PATH_ME_SUGGESTION, fields);

    if (pinData != null) {
      if (pinData.errorOccured) {
        return PinResult(
          errorData: pinData as PinErrorData
        );
      } else {
        final PinRootData pinRootData = pinData as PinRootData;
        return PinResult(
          successData: List<BoardInfo>.generate(pinRootData.data.length, (int index) => BoardInfo.fromJson(pinRootData.data[index]))
        );
      }
    } else {
      return PinResult.empty();
    }
  }

  ///Return the users that follow the logged in user
  ///
  ///Note: Not working for some reason
  Future<PinResult<List<UserInfo>>> getMyFollowers({String cursor, List<FieldData> fields}) async {
    throw UnsupportedError('Not yet implemented');

    /*filterFields(ME_GET_MY_FOLLOWERS_CODE, fields);

    final PinData pinData = await getJsonPinData(PATH_ME_FOLLOWERS);

    if (pinData != null) {
      if (pinData.errorOccured) {
        return PinResult(
          errorData: pinData as PinErrorData
        );
      } else {
        final PinRootData pinRootData = pinData as PinRootData;
        return PinResult(
          successData: List<UserInfo>.generate(pinRootData.data.length, (int index) => UserInfo.fromJson(pinRootData.data[index]))
        );
      }
    } else {
      return PinResult.empty();
    }*/
  }

  Future<PinResult<List<BoardInfo>>> getFollwingBoards({String cursor, List<FieldData> fields}) async {
    throw UnsupportedError('Not yet implemented');

    /*filterFields(ME_GET_MY_SUGGESTION_CODE, fields);

    final PinData pinData = await getJsonPinData(PATH_ME_FOLLOWING_BOARDS, fields);

    if (pinData != null) {
      if (pinData.errorOccured) {
        return PinResult(
          errorData: pinData as PinErrorData
        );
      } else {
        final PinRootData pinRootData = pinData as PinRootData;
        return PinResult(
          successData: List<BoardInfo>.generate(pinRootData.data.length, (int index) => BoardInfo.fromJson(pinRootData.data[index]))
        );
      }
    } else {
      return PinResult.empty();
    }*/
  }

  bool followBoard(BoardInfo board) => throw UnsupportedError('Not yet implemented');

  bool unfollowBoard(BoardInfo board) => throw UnsupportedError('Not yet implemented');

  Future<PinResult<List<dynamic>>> getMyInterrests({String cursor, List<FieldData> fields}) async {
    return null;
  }

  List<UserInfo> getMyFollowings({
    String cursor,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');

  bool followUser(UserInfo user) => throw UnsupportedError('Not yet implemented');

  bool unfollowUser(UserInfo user) => throw UnsupportedError('Not yet implemented');

  List<PinInfo> getMyPins({
    String cursor,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');

  List<BoardInfo> getSearchedBoards(String query, {
    String cursor,
    List<FieldData> fields
  }
  ) => throw UnsupportedError('Not yet implemented');

  List<PinInfo> getSearchedPins(String query, {
    String cursor,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');
}

class Pin {
  static const Pin _inst = Pin._();

  const Pin._();

  factory Pin() => _inst;

  bool createPin(BoardInfo board, String note, {
    String link,
    String image,
    String imageUrl,
    String imageBase64
  }) => throw UnsupportedError('Not yet implemented');

  bool deletePin(PinInfo pin) => throw UnsupportedError('Not yet implemented');

  bool editPin(PinInfo pin, {
    BoardInfo board,
    String note,
    String link,
    List<FieldData> fields
  }) => throw UnsupportedError('Not yet implemented');

  PinInfo getPin(PinInfo pin, [List<FieldData> fields]) => throw UnsupportedError('Not yet implemented');
}

class User {
  static const User _inst = User._();

  const User._();

  factory User() => _inst;

  UserInfo getUserInfo(String user, [List<FieldData> fields]) => throw UnsupportedError('Not yet implemented');
}
