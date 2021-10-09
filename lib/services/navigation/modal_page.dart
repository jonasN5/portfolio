import 'package:flutter/material.dart';

/// A [Page] with no transition animation display as a [ModalRoute].
class ModalNoAnimationPage extends Page<dynamic> {
  const ModalNoAnimationPage({
    LocalKey? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) => PageRouteBuilder<dynamic>(
        settings: this,
        opaque: false,
        fullscreenDialog: true,
        barrierDismissible: true,
        pageBuilder: (_, __, ___) => child,
      );
}
