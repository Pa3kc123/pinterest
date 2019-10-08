import 'dart:io';

import 'package:pinterest/pinterest.dart' as pinterest;

main() {
  pinterest.accessToken = 'AjdRdAK5so_p4LHYbdpe7q7HcLd5FcXT2lRXIJVGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA';
  pinterest.section.getSectionsFromBoard(null).then((pinterest.PinResult<List<pinterest.SectionInfo>> result) {
    if (result.errorOccured) {
      print(result.errorData.message);

      if (result.errorData.statusCode == HttpStatus.tooManyRequests) {
        print(result.errorData.rateLimit);
        print(result.errorData.rateRemaining);
      }
    } else {
      final StringBuffer buffer = StringBuffer();

      for (pinterest.SectionInfo section in result.successData) {
        buffer.writeln('section.id = ${section.id}');
      }

      print(buffer);
    }
  });
}
