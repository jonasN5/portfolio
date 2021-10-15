import 'package:flutter/material.dart';
import 'package:portfolio/utils/extensions.dart';

class AppStyle {
  /// Return a theme with font sizes depending on the screen size.
  static ThemeData getAppThemeData(BuildContext context) => context.isMobile
      ? Theme.of(context).copyWith(
          inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
              errorStyle: Theme.of(context)
                  .inputDecorationTheme
                  .errorStyle!
                  .copyWith(fontSize: 12)),
          textTheme: Theme.of(context).textTheme.copyWith(
              bodyText2:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
              subtitle1: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(fontSize: 14)))
      : Theme.of(context);

  /// Return a title size depending on the screen size.
  static TextStyle getTitleStyle(BuildContext context) => TextStyle(
      fontSize: context.isMobile
          ? Theme.of(context).textTheme.headline6!.fontSize
          : Theme.of(context).textTheme.headline5!.fontSize);
}
