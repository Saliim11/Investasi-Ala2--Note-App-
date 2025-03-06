import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static const String _id = 'idUser';

  //simpan id
  static void saveId(String id){
    SharedPreferences.getInstance().then((value) {
      value.setString(_id, id);
    });
  }

  // ambil id
  static Future getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString(_id) ?? '';
    return id;
  }

  static void removeId(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove(_id);
    });
  }
}