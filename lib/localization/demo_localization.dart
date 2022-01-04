import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
  }

  Map<String, String>? _localizedValues;

  Future<bool> loadJson() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
    await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedValues = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String? translate(String key) {
    return _localizedValues![key];
  }

  // static member to have simple access to the delegate from Material App
  static const LocalizationsDelegate<DemoLocalizations> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'fa'].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalizations> load(Locale locale) async {
    DemoLocalizations localization = new DemoLocalizations(locale);
    await localization.loadJson();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) => false;
}

// class DemoLocalizations {
//   DemoLocalizations(this.locale);
//
//   final Locale locale;
//
//   static DemoLocalizations of(BuildContext context) {
//     return Localizations.of<DemoLocalizations>(context, DemoLocalizations)!;
//   }
//
//   Map<String, String>? _localizedValues;
//
//   Future load() async {
//     String jsonStringValues =
//     await rootBundle.loadString('lib/lang/${locale.languageCode}.json');
//     Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
//     _localizedValues =
//         mappedJson.map((key, value) => MapEntry(key, value.toString()));
//   }
//
//   String getTranslatedValue(String key){
//     return _localizedValues[];
//   }
// }
