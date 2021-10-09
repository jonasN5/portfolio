import 'dart:convert';
import 'package:http/http.dart';
import 'package:portfolio/resources/email_info.dart';
import 'package:portfolio/ui/contact/contact_screen.dart';

/// Simple class to decouple the business logic from [ContactScreen].
class ContactViewModel {
  String? name;
  String? email;
  String? message;

  /// Send the message.
  Future<void> sendMessage() async {
    final uri = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    final response = await post(uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "service_id": serviceId,
          "template_id": templateId,
          "user_id": userId,
          "template_params": {
            "from_name": name,
            "from_email": email,
            "message": message,
          },
        }));
    if (response.statusCode == 200) {
      return Future.value();
    } else {
      return Future.error("");
    }
  }
}
