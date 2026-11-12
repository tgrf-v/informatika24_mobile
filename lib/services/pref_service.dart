
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/barang.dart';

class PrefService {
  static const String _key = 'inventaris_v1';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  // Menyimpan daftar barang ke SharedPreferences
  Future<void> simpanBarang(List<Barang> daftarBarang) async {
    final String jsonData = jsonEncode(
      daftarBarang.map((barang) => barang.toJson()).toList(),
    );

    await _prefs.setString(_key, jsonData);
  }

  // Memuat daftar barang dari SharedPreferences
  Future<List<Barang>> muatBarang() async {
    final String? jsonData = await _prefs.getString(_key);

    if (jsonData == null || jsonData.isEmpty) {
      return [];
    }

    final List<dynamic> data = jsonDecode(jsonData);

    return data.map((item) {
      return Barang.fromJson(Map<String, dynamic>.from(item));
    }).toList();
  }
}
