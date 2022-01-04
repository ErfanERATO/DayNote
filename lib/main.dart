import 'package:day_note_/localization/demo_localization.dart';
import 'package:day_note_/localization/language_constants.dart';
import 'package:day_note_/page/note_page.dart';
import 'package:day_note_/page/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(DayNote());
}


class DayNote extends StatefulWidget {
  const DayNote({Key? key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _DayNoteState? state = context.findAncestorStateOfType<_DayNoteState>();
    state!.setLocale(newLocale);
  }


  @override
  _DayNoteState createState() => _DayNoteState();
}

class _DayNoteState extends State<DayNote> {
  Locale? _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "DayNote",
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
      locale: _locale,
      supportedLocales: const [
        Locale("en", "US"),
        Locale("fa", "IR"),
      ],
      localizationsDelegates: const [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
    // home: const NotesPage(),
    home: const SplashScreen(),
  );
  }
}
