import 'package:url_launcher/url_launcher.dart';

extension StringFormatter on String {
  /// Capitalize the first character or the String
  String capitalize() {
    if (this == '') return '';
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  /// Open a given URL.
  Future<void> openURL() async => await canLaunch(this)
      ? await launch(this)
      : throw "Could not launch $this";
}
