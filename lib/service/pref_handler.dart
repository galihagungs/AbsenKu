import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const String _id = 'idUser';
  static const String _token = "";

  static void saveId(String id) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_id, id);
    });
  }

  //For getting user id
  static Future getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(_id) ?? '';
    return id;
  }

  // For removing user id
  static void removeId() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }

  static void saveToken(String token) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(_token, token);
    });
  }

  //For getting user id
  static Future getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(_token) ?? '';
    return token;
  }

  // For removing user id
  static void removeToken() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }
}
