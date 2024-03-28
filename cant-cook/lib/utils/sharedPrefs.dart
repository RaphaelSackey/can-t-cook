import 'package:camera/camera.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThresholdsPrefs {
  static SharedPreferences? _valuePrefs;
  init() async {
    _valuePrefs ??= await SharedPreferences.getInstance();
  }

  // _________________________ Username sharedPreferences ____________________________
  set username(String value) {
    _valuePrefs?.setString(keyUsername, value);
  }

  String get username => _valuePrefs?.getString(keyUsername) ?? 'Cant_Cooker';

  // _________________________ Registered sharedPreferences ____________________________
  set isRegistered(bool value) {
    _valuePrefs?.setBool(keyIsRegistered, value);
  }

  bool get isRegistered => _valuePrefs?.getBool(keyIsRegistered) ?? false;
}

final sharedPrefs = ThresholdsPrefs();
late CameraDescription firstCamera;
List<String> ingredients = [];
const keyUsername = 'username';
const keyIsRegistered = 'isRegistered';