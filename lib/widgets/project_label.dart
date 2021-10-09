import 'package:flutter/material.dart';

/// Simple wrapper to display a [text] with some rounded decoration.
class ProjectLabel extends StatelessWidget {
  final String text;

  const ProjectLabel({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(4))),
        padding: EdgeInsets.all(4),
        child: Text(text));
  }
}
