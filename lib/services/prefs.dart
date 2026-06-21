import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const _geminiKey = 'gemini_api_key';

  static Future<String?> getGeminiApiKey() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_geminiKey);
  }

  static Future<void> setGeminiApiKey(String key) async {
    final p = await SharedPreferences.getInstance();
    if (key.isEmpty) {
      await p.remove(_geminiKey);
    } else {
      await p.setString(_geminiKey, key);
    }
  }
}
