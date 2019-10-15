import 'package:pinterest/pinterest.dart' as pinterest;

main() {
  pinterest.accessToken = 'Al5rcx-BEj1tNf6bdwBDYTj9sqX1Fcvr7Mwm2KNGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA';
  pinterest.user.getUserInfo("diogolobo1975")
    ..then((pinterest.PinResult<pinterest.UserInfo> result) {
      print(result.runtimeType);
      if (result != null && !result.isResultEmpty) {
        print(result.successData);
      } else {
        print(result?.errorData ?? "result == null");
      }
    })
    ..catchError((dynamic error) {
      print(error.runtimeType);
      print(error);
    });
}
