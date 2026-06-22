import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/history_entry.dart';

class Prefs {
  static const _geminiKey = 'gemini_api_key';
  static const _historyKey = 'contract_history';

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

  static Future<void> saveEntry(HistoryEntry entry) async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getStringList(_historyKey) ?? [];
    raw.insert(0, jsonEncode(entry.toJson()));
    await p.setStringList(_historyKey, raw);
  }

  static Future<List<HistoryEntry>> loadHistory() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getStringList(_historyKey) ?? [];
    return raw
        .map((s) {
          try {
            return HistoryEntry.fromJson(
                jsonDecode(s) as Map<String, dynamic>);
          } catch (_) {
            return null;
          }
        })
        .whereType<HistoryEntry>()
        .toList();
  }
}
