import 'package:flutter/material.dart';

const kTabletBreakpoint = 768.0;
const kDesktopBreakpoint = 1440.0;

/// A responsive widget to build it's child depending on the current screen size.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout(
      {required this.mobile, this.tablet, required this.desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, dimens) {
      if (dimens.maxWidth < kTabletBreakpoint) {
        return mobile;
      } else if (dimens.maxWidth < kDesktopBreakpoint) {
        return tablet ?? desktop;
      } else {
        return desktop;
      }
    });
  }
}
