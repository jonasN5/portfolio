import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:portfolio/resources/keys.dart';
import 'package:portfolio/widgets/max_width_container.dart';
import 'package:portfolio/widgets/responsive_layout.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:portfolio/resources/strings.dart';
import 'package:portfolio/ui/common/root.dart';
import 'package:portfolio/ui/contact/contact_viewmodel.dart';

/// Send a message. Performs the necessary validations before doing so. The
/// optional [model] will allow mocking the class for unit testing.
class ContactScreen extends StatefulWidget {
  final ContactViewModel? model;

  const ContactScreen({Key? key, this.model}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ContactViewModel _model;

  /// Keep track of the form's globalKey
  final GlobalKey<FormState> _globalFormKey = GlobalKey<FormState>();

  /// Track the state of the send message post request to update the button
  /// accordingly.
  ButtonState sendEmailState = ButtonState.idle;

  @override
  void initState() {
    super.initState();
    _model = widget.model ?? ContactViewModel();
  }

  /// Make sure name and message are provided.
  String? _validateNameAndMessage(String? text) {
    if (text == null || text.isEmpty) {
      return AppStrings.required.tr();
    } else {
      return null;
    }
  }

  /// Valid the email address.
  String? _validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return AppStrings.required.tr();
    } else {
      final bool isEmail = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9_-]+\.[a-zA-Z]+")
          .hasMatch(text);
      if (isEmail) {
        return null;
      } else {
        return AppStrings.invalid_email.tr();
      }
    }
  }

  /// Perform validation checks on all fields and if valid, call [sendEmail].
  void _validateAndSaveAndSend() {
    final form = _globalFormKey.currentState;
    if (form != null && form.validate()) {
      form.save();
      sendMessage();
    }
  }

  /// Send the message and update [sendEmailState] status accordingly.
  void sendMessage() {
    setState(() {
      sendEmailState = ButtonState.loading;
      _model.sendMessage().then((value) {
        setState(() {
          sendEmailState = ButtonState.success;
        });
      }).catchError((e, stack) {
        setState(() {
          sendEmailState = ButtonState.fail;
        });
      }).whenComplete(() {
        // Reset the state after success/error.
        Future.delayed(Duration(seconds: 2), () {
          if (mounted)
            setState(() {
              sendEmailState = ButtonState.idle;
            });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return RootWidget(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          MaxWidthContainer(
            child: Form(
                key: _globalFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Name
                    SizedBox(
                      width: 380,
                      child: TextFormField(
                          onSaved: (value) => _model.name = value,
                          keyboardType: TextInputType.text,
                          validator: _validateNameAndMessage,
                          decoration: InputDecoration(
                            labelText: AppStrings.name.tr(),
                            hintText: AppStrings.enter_name.tr(),
                          )),
                    ),

                    SizedBox(height: 16),

                    /// Email
                    SizedBox(
                      width: 380,
                      child: TextFormField(
                          onSaved: (value) => _model.email = value,
                          validator: _validateEmail,
                          decoration: InputDecoration(
                            labelText: AppStrings.email.tr(),
                            hintText: AppStrings.enter_email.tr(),
                          )),
                    ),

                    SizedBox(height: 16),

                    /// Message
                    TextFormField(
                      key: Key(AppKeys.message_form_field),
                      onSaved: (value) => _model.message = value,
                      validator: _validateNameAndMessage,
                      minLines: 8,
                      maxLines: 12,
                      decoration: InputDecoration(
                        labelText: AppStrings.message.tr(),
                        hintText: AppStrings.enter_message.tr(),
                      ),
                    ),

                    SizedBox(height: 48),

                    /// Send button
                    Center(
                        child: ProgressButton.icon(
                            textStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.width <
                                        kTabletBreakpoint
                                    ? 14
                                    : 20),
                            iconedButtons: {
                              ButtonState.idle: IconedButton(
                                  text: AppStrings.send.tr(),
                                  icon: Icon(Icons.send, color: Colors.white),
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              ButtonState.loading: IconedButton(
                                  text: AppStrings.sending.tr(),
                                  color: Theme.of(context).primaryColor),
                              ButtonState.fail: IconedButton(
                                  text: AppStrings.failed.tr(),
                                  icon: Icon(Icons.cancel, color: Colors.white),
                                  color: Colors.red.shade300),
                              ButtonState.success: IconedButton(
                                  text: AppStrings.sent.tr(),
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  color: Colors.green.shade400)
                            },
                            onPressed: _validateAndSaveAndSend,
                            state: sendEmailState)),
                  ],
                )),
          )
        ],
      ),
    ));
  }
}
