import 'package:flutter/material.dart';

/// Widget that notifies of its size by triggering [sizeValueNotifier]
/// once laid out.
class SizeTrackingWidget extends StatefulWidget {
  final Widget? child;
  final ValueNotifier<Size> sizeValueNotifier;

  SizeTrackingWidget(
      {Key? key, required this.sizeValueNotifier, required this.child})
      : super(key: key);

  @override
  _SizeTrackingWidgetState createState() => _SizeTrackingWidgetState();
}

class _SizeTrackingWidgetState extends State<SizeTrackingWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getSize();
    });
  }

  _getSize() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    widget.sizeValueNotifier.value = renderBox.size;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }
}
