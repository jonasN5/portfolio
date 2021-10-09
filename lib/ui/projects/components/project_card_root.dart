import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/widgets/project_label.dart';

/// Root layout for a single project handling the enter animation and
/// standardizing the [title] and [labels].
class ProjectCardRoot extends StatefulWidget {
  /// The project specific widget to display.
  final Widget child;

  /// The title to display.
  final String title;

  /// The callback called when the enter animation ended.
  final VoidCallback? onEnterAnimationEnd;

  /// An optional delay before starting the enter animation.
  final Duration enterAnimationDelay;

  /// Any labels to display.
  final List<String> labels;

  const ProjectCardRoot(
      {Key? key,
      required this.child,
      required this.title,
      this.enterAnimationDelay = const Duration(),
      this.onEnterAnimationEnd,
      this.labels = const []})
      : super(key: key);

  @override
  State<ProjectCardRoot> createState() => _ProjectCardRootState();
}

class _ProjectCardRootState extends State<ProjectCardRoot>
    with SingleTickerProviderStateMixin {
  late AnimationController _enterController;

  @override
  void initState() {
    super.initState();
    _enterController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    // Run the enter animation when the setup is done.
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(
          widget.enterAnimationDelay,
          () => _enterController.forward().then((value) {
                widget.onEnterAnimationEnd?.call();
              }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _enterController,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: kIsWeb ? 120 : 40),
          widget.child,
          Container(
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Hero(
                      tag: widget.title,
                      child: Material(
                          color: Colors.transparent,
                          child: Text(widget.title,
                              style: TextStyle(
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .headline5!
                                      .fontSize)))),
                ),
                ...widget.labels.map((e) => ProjectLabel(text: e.tr()))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }
}
