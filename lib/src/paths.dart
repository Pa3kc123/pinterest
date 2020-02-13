class PinterestPath {
  final PathAndFilter GET;
  final PathAndFilter POST;
  final PathAndFilter PATCH;

  const PinterestPath({
    this.GET,
    this.POST,
    this.PATCH
  });
}

class PathAndFilter {
  final String path;
  final int filter;

  const PathAndFilter(this.path, this.filter);
}

const PinterestPath ME_GET_MY_INFO = PinterestPath(
  PathAndFilter('/me', 0x601e65)
);
const PathAndFilter ME_GET_MY_BOARDS = PathAndFilter('/me/boards', 0x390de0);
const PathAndFilter ME_GET_MY_SUGGESTION_CODE = PathAndFilter('/me/boards/suggested', 0x390de0);
const PathAndFilter ME_GET_MY_FOLLOWERS_CODE = PathAndFilter('/me/followers', 0x601e65);
const PathAndFilter ME_GET_FOLLWING_BOARDS_CODE = PathAndFilter('/me/following/boards', 0x390de0);
const PathAndFilter ME_GET_MY_INTERRESTS_CODE = PathAndFilter('/me/following/interests', 0x10400);
const PathAndFilter ME_GET_MY_FOLLOWINGS_CODE = PathAndFilter('/me/following/users', 0x601e65);
const PathAndFilter ME_GET_MY_PINS_CODE = PathAndFilter('???', 0x26ecfa);
const PathAndFilter ME_GET_SEARCHED_BOARDS_CODE = PathAndFilter('???', 0x390de0);
const PathAndFilter ME_GET_SEARCHED_PINS_CODE = PathAndFilter('???', 0x26ecfa);
