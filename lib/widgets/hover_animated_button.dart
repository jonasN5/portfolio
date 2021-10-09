import 'package:flutter/material.dart';
import 'package:portfolio/widgets/size_tracking_widget.dart';

/// A button which animates an underline below [child] when hovered on it.
/// [onPressed] is called when the button is pressed.
class HoverAnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Widget? icon;

  const HoverAnimatedButton(
      {Key? key, required this.onPressed, required this.child, this.icon})
      : super(key: key);

  @override
  _HoverAnimatedButtonState createState() => _HoverAnimatedButtonState();
}

class _HoverAnimatedButtonState extends State<HoverAnimatedButton>
    with SingleTickerProviderStateMixin {
  /// Will hold the Widget size once laid out. The size is necessary to animate
  /// the container, since the container width has to match the widget size.
  /// When set, [ValueListenableBuilder] will rebuild the container.
  ValueNotifier<Size> _size = ValueNotifier<Size>(Size(0, 0));

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  /// Triggered when the mouse enters or exits the widget region. Starts or
  /// reverses the appropriate animation.
  void onHover(bool value) {
    if (value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  /// Called when the widget (button) is pressed.
  void onTap() {
    widget.onPressed.call();
    // Reset the animation controller to avoid any glitch on page change.
    _animationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: widget.icon!,
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizeTrackingWidget(
                  sizeValueNotifier: _size,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, right: 4, left: 4, bottom: 2),
                    child: widget.child,
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: SizeTransition(
                  axis: Axis.horizontal,
                  sizeFactor: _animationController,
                  child: ValueListenableBuilder(
                      valueListenable: _size,
                      builder: (context, Size size, _) {
                        return Container(
                            height: 3,
                            width: size.width,
                            color: Theme.of(context).primaryColor);
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
