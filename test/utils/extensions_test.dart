import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/utils/extensions.dart';

void main() {

  group("String extensions", () {
    test("Should capitalize the first letter", () {
      final testString = "testString";
      final capitalized = testString.capitalize();
      expect(capitalized, "TestString");
    });
  });
}
