import 'package:flutter/material.dart';

/// A simple page that does not animation transitions, as opposed to a typical
/// [MaterialPage].
class NoAnimationPage extends Page<dynamic> {
  const NoAnimationPage({
    LocalKey? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) => PageRouteBuilder<dynamic>(
        settings: this,
        pageBuilder: (_, __, ___) => child,
      );
}