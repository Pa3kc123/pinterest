import 'core.dart';
import 'fields.dart';
import 'models.dart';
import 'util.dart';

class Section {
  static const Section _inst = Section._();

  static const GET_SECTIONS_FOR_BOARD_PATH = Path('/board/<board>/sections');
  static const CREATE_NEW_BOARD_SECTION_PATH = Path('/board/<board>/sections');
  static const DELETE_BOARD_SECTION_PATH = Path('/board/sections/<section>');
  static const GET_PINS_FOR_BOARD_SECTION_PATH = Path('/board/sections/<section_spec:section>/pins');

  const Section._();

  factory Section() => _inst;

  bool createSection(BoardInfo board, String title, [List<PinInfo> initialPins]) => throw UnsupportedError('Not yet implemented');
  Future<List<SectionInfo>> getSectionsFromBoard(BoardInfo board, [String cursor]) => throw UnsupportedError('Not yet implemented');
  bool removeSection(SectionInfo section) => throw UnsupportedError('Not yet implemented');
  List<PinInfo> getPinsFromSection(SectionInfo section, [String cursor]) => throw UnsupportedError('Not yet implemented');
}

class Board {
  static const Board _inst = Board._();

  static const CREATE_BOARD_PATH = PathWithFilter('/boards', 0x390de0);
  static const REMOVE_BOARD_PATH = Path('/boards/<board_spec:board>');
  static const EDIT_BOARD_PATH = PathWithFilter('/boards/<board_spec:board>', 0x390de0);
  static const GET_BOARD_INFO_PATH = PathWithFilter('/boards/<board_spec:board>', 0x390de0);
  static const GET_PINS_FROM_BOARD_PATH = PathWithFilter('/boards/<board_spec:board>/pins', 0x26ecfa);

  const Board._();

  factory Board() => _inst;

  Future<bool> createBoard(String name, {
    String description,
    List<FieldData> fields
  }) async => throw UnsupportedError('Not yet implemented');
  Future<bool> removeBoard(BoardInfo board) async => throw UnsupportedError('Not yet implemented');
  Future<bool> editBoard(BoardInfo board, {
    String name,
    String description,
    List<FieldData> fields
  }) async => throw UnsupportedError('Not yet implemented');
  Future<BoardInfo> getBoardInfo(BoardInfo board, [List<FieldData> fields]) async => throw UnsupportedError('Not yet implemented');
  Future<List<PinInfo>> getPinsFromBoard(BoardInfo board, {
    String cursor,
    List<FieldData> fields
  }) async => throw UnsupportedError('Not yet implemented');
}

class Me {
  static const Me _inst = Me._();

  static const GET_MY_INFO_PATH = PathWithFilter('/me', 0x601e65);
  static const GET_MY_BOARDS_PATH = PathWithFilter('/me/boards', 0x390de0);
  static const GET_MY_SUGGESTIONS_PATH = PathWithFilter('/me/boards/suggested', 0x390de0);
  static const GET_MY_FOLLOWERS_PATH = PathWithFilter('/me/followers', 0x601e65);
  static const GET_FOLLWING_BOARDS_PATH = PathWithFilter('/me/following/boards', 0x390de0);
  static const FOLLOW_BOARD_PATH = PathWithFilter('/me/following/boards', 0x390de0);
  static const UNFOLLOW_BOARD_PATH = PathWithFilter('/me/following/boards/<board_spec:board>', 0x390de0);
  static const GET_MY_INTERRESTS_PATH = PathWithFilter('/me/following/interests', 0x10400);
  static const GET_MY_FOLLOWINGS_PATH = PathWithFilter('/me/following/users', 0x601e65);
  static const FOLLOW_USER_PATH = PathWithFilter('/me/following/users', 0x601e65);
  static const UNFOLLOW_USER_PATH = PathWithFilter('/me/following/users/<user>', 0x601e65);
  static const GET_MY_PINS_PATH = PathWithFilter('/me/pins', 0x26ecfa);
  static const GET_SEARCHED_BOARDS_PATH = PathWithFilter('/me/search/boards', 0x390de0);
  static const GET_SEARCHED_PINS_PATH = PathWithFilter('/me/search/pins', 0x26ecfa);

  const Me._();

  factory Me() => _inst;

  //Return the logged in user's information
  Future<UserInfo> getMyInfo([List<FieldData> fields]) async {
    filterFields(GET_MY_INFO_PATH, fields);

    final data = await getJsonPinData(GET_MY_INFO_PATH, fields);

    if (data.statusCode != 200) {
      throw PinException(data);
    }

    final msg = PinterestMessage<Map<String, dynamic>>()..decode(data.json);

    return msg.data as UserInfo;
  }

  ///Return the logged in user's Boards
  Future<List<BoardInfo>> getMyBoards([List<FieldData> fields, int limit]) async => throw UnsupportedError('Not yet implemented');

  ///Return Board suggestions for the logged in user
  Future<List<BoardInfo>> getMySuggestion({int count, PinInfo pin, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  ///Return the users that follow the logged in user
  ///
  ///Note: Not working for some reason
  Future<List<UserInfo>> getMyFollowers({String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  ///Note: Not working for some reason
  Future<List<BoardInfo>> getFollwingBoards({String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  Future<bool> followBoard(BoardInfo board) async => throw UnsupportedError('Not yet implemented');

  Future<bool> unfollowBoard(BoardInfo board) async => throw UnsupportedError('Not yet implemented');

  Future<List<BoardInfo>> getMyInterrests({String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  Future<List<UserInfo>> getMyFollowings({String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  Future<bool> followUser(UserInfo user) async => throw UnsupportedError('Not yet implemented');

  Future<bool> unfollowUser(UserInfo user) async => throw UnsupportedError('Not yet implemented');

  Future<List<PinInfo>> getMyPins({String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  Future<List<BoardInfo>> getSearchedBoards(String query, {String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');

  Future<List<PinInfo>> getSearchedPins(String query, {String cursor, List<FieldData> fields}) async => throw UnsupportedError('Not yet implemented');
}

class Pin {
  static const Pin _inst = Pin._();

  static const CREATE_PIN = PathWithFilter('/pins', 0x26ecfa);
  static const DELETE_PIN = Path('/pins/<pin_spec:pin>');
  static const EDIT_PIN = PathWithFilter('/pins/<pin_spec:pin>', 0x26ecfa);
  static const GET_PIN = PathWithFilter('/pins/<pin_spec:pin>', 0x26ecfa);

  const Pin._();

  factory Pin() => _inst;

  Future<bool> createPin(BoardInfo board, String note, {
    String link,
    String image,
    String imageUrl,
    String imageBase64
  }) async => throw UnsupportedError('Not yet implemented');

  Future<bool> deletePin(PinInfo pin) async => throw UnsupportedError('Not yet implemented');

  Future<bool> editPin(PinInfo pin, {
    BoardInfo board,
    String note,
    String link,
    List<FieldData> fields
  }) async => throw UnsupportedError('Not yet implemented');

  Future<PinInfo> getPin(PinInfo pin, [List<FieldData> fields]) async => throw UnsupportedError('Not yet implemented');
}

class User {
  static const User _inst = User._();

  static const GET_USER_INFO_PATH = PathWithFilter('/users/<user>', 0x601e65);

  const User._();

  factory User() => _inst;

  Future<UserInfo> getUserInfo(String user, [List<FieldData> fields]) async => throw UnsupportedError('Not yet implemented');
}
