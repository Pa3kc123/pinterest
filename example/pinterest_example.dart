import 'dart:io';

import 'package:pinterest/pinterest.dart' as pinterest;

main() {
  pinterest.accessToken = 'AjdRdAK5so_p4LHYbdpe7q7HcLd5FcXT2lRXIJVGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA';
  pinterest.me.getMySuggestion().then((pinterest.PinResult<List<pinterest.BoardInfo>> result) {
    if (result.errorOccured) {
      print(result.errorData.message);

      if (result.errorData.statusCode == HttpStatus.tooManyRequests) {
        print(result.errorData.rateLimit);
        print(result.errorData.rateRemaining);
      }
    } else {
      for (pinterest.BoardInfo board in result.successData) {
        final StringBuffer buffer = StringBuffer();

        buffer.writeln('board.name = ${board.name}');
        buffer.writeln('board.id = ${board.id}');
        buffer.writeln('board.description = ${board.description}');
        buffer.writeln('board.createdAt = ${board.createdAt}');

        print(buffer);
      }
    }
  });
}
