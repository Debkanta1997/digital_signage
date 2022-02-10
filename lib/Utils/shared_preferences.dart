import 'package:shared_preferences/shared_preferences.dart';
String ISLOGIN="isLogin"; //1 - logged in   0 - not login
String USERID="user_id";

void writeSharedPreferences(String key, String value) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> readSharedPreferences(String key, String defaultValue) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? defaultValue;
}
