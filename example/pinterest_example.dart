import 'package:pinterest/pinterest.dart' as pinterest;

//! Last status report
// 308
// <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
// <title>Redirecting...</title>
// <h1>Redirecting...</h1>
// <p>You should be redirected automatically to target URL: <a href="https://api.pinterest.com/v1/me/?access_token=AtOWyz84uNf-RzwXiHI6apV_fak1Fc4NtJ0yc6NGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA">https://api.pinterest.com/v1/me/?access_token=AtOWyz84uNf-RzwXiHI6apV_fak1Fc4NtJ0yc6NGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA</a>.  If not click the link.
// Exited


void main() {
  pinterest.accessToken = 'AtOWyz84uNf-RzwXiHI6apV_fak1Fc4NtJ0yc6NGKq0eacCsVQhmwDAAAeYZRiq81gxAqssAAAAA';
  pinterest.requestAllFields = true;

  pinterest.me.getMyInfo()
    .then((pinterest.UserInfo value) => print(value))
    .catchError((error) => {
    if (error is pinterest.PinException) {
      print(error.statusCode),
      print(error.optionalMessage)
    } else {
      print(error)
    }
  });
}
