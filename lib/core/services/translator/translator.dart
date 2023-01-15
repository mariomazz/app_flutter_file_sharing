import 'dart:convert';
import 'package:flutter/services.dart';

final Translator translator = Translator.instance;

class Translator {
  static late final Translator _instance;
  static Translator get instance => _instance;
  static const _languagesSupported = ["it", "en"];
  static Future<Translator> loadLanguage() async {
    _instance = Translator();
    _instance._setJson(
        await _instance._fetchLanguage(await _instance._getDefaultLanguage()));
    return _instance;
  }

  final _json = <String, dynamic>{};

  Map<String, dynamic> get all => _json;

  Future<String> _getDefaultLanguage() async {
    return _languagesSupported.first;
  }

  Future<Map<String, dynamic>> _fetchLanguage(String language) async {
    if (_languagesSupported.contains(language)) {
      return jsonDecode(
          await rootBundle.loadString("assets/languages/$language.json"));
    } else {
      return {};
    }
  }

  void _setJson(Map<String, dynamic> json) {
    return _json.addAll(json);
  }

  String get(String input) {
    String finalString = "";
    _json.forEach((key, value) {
      if (key == input && value is String) {
        finalString = value;
      }
    });

    return finalString;
  }
}
