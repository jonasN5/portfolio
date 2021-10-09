
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/constants.dart';

/// Simple class used as a singleton to track the current [Locale].
class LocaleManager {

  Locale currentLocale = AppConstants.SUPPORTED_LOCALES[0];

  /// Flag used when the language has been changed to allow rebuilding the pages
  /// dynamically.
  bool hasLocaleChanged = false;



}