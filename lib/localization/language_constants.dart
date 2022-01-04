import 'package:flutter/material.dart';
import 'package:day_note_/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String language_code = 'languageCode';

//languages code
const String english = 'en';
const String farsi = 'fa';


Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(language_code, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(language_code) ?? "fa";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case english:
      return const Locale(english, 'US');
    case farsi:
      return const Locale(farsi, "IR");
    default:
      return const Locale(farsi, "IR");
  }
}

String? getTranslated(BuildContext context, String key) {
  return DemoLocalizations.of(context).translate(key);
}
