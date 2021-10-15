import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/resources/constants.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/services/locale_manager.dart';
import 'package:portfolio/services/service_locator.dart';

/// Allows changing the app languages dynamically using a drop down list.
class LanguageSelector extends StatelessWidget {
  /// If true, displays the language in abbreviated form, e.g. 'EN', otherwise
  /// 'English'.
  final bool compactDisplay;

  const LanguageSelector({Key? key, this.compactDisplay = false})
      : super(key: key);

  static const localizedLanguages = {
    'en': 'English',
    'fr': 'Français',
    'de': 'Deutsch'
  };

  void onChanged(BuildContext context, Locale? locale) {
    if (locale != null) {
      // Set the new Locale globally to be able to retrieve it without context
      serviceLocator<LocaleManager>().hasLocaleChanged = true;
      serviceLocator<LocaleManager>().currentLocale = locale;
      // Trigger easy localization rebuild
      context.setLocale(locale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      key: Key(AppKeys.language_selector),
      child: DropdownButton<Locale>(
        iconSize: 0.0,
        value: context.locale,
        onChanged: (value) => onChanged(context, value),
        items: AppConstants.SUPPORTED_LOCALES.map((locale) {
          return DropdownMenuItem<Locale>(
              value: locale,
              child: Row(
                children: [
                  Container(
                    width: compactDisplay ? 24 : 96,
                    child: Text(compactDisplay
                        ? locale.languageCode.toUpperCase()
                        : localizedLanguages[locale.languageCode]!),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    child: SvgPicture.asset(
                        'assets/logos/${locale.languageCode}.svg',
                        width: 24,
                        height: 24),
                  )
                ],
              ));
        }).toList(),
      ),
    );
  }
}
