import 'package:flutter/material.dart';

/// A 404 like page when an invalid url in entered in the browser.
class NotFound extends StatelessWidget {
  const NotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Not Found")),
      body: SafeArea(
        child: Center(
          child: Text(
            "Page Not Found",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}