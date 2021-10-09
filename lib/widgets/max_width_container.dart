import 'package:flutter/material.dart';

/// Give a [child] widget constraints to prevent it from stretching too much.
/// This is meaningful when used for the web.
class MaxWidthContainer extends StatelessWidget {
  final Widget child;

  const MaxWidthContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800), child: child),
    );
  }
}
