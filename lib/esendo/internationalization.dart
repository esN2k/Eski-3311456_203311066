import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class EDLocalizations {
  EDLocalizations(this.locale);

  final Locale locale;

  static EDLocalizations of(BuildContext context) =>
      Localizations.of<EDLocalizations>(context, EDLocalizations);

  static List<String> languages() => ['tr'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String trText = '',
  }) =>
      [trText][languageIndex] ?? '';
}

class EDLocalizationsDelegate extends LocalizationsDelegate<EDLocalizations> {
  const EDLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      EDLocalizations.languages().contains(locale.languageCode);

  @override
  Future<EDLocalizations> load(Locale locale) =>
      SynchronousFuture<EDLocalizations>(EDLocalizations(locale));

  @override
  bool shouldReload(EDLocalizationsDelegate old) => false;
}

final kTranslationsMap =
    <Map<String, Map<String, String>>>[].reduce((a, b) => a..addAll(b));
