import 'package:ecom/views/MainHome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/PasswordInput.dart';
import '../components/emailInput.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passController = TextEditingController();
    final textFieldFocusNode = FocusNode();
    bool _obscured = true;
    bool _emailvalidate = false;
    bool _passvalidate = false;

    void _toggleObscured() {
      setState(() {
        _obscured = !_obscured;
        if (textFieldFocusNode.hasPrimaryFocus)
          return; // If focus is on text field, dont unfocus
        textFieldFocusNode.canRequestFocus =
        false; // Prevents focus if tap on eye
      });
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 105, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child:
                      EmailInputWidget(emailController: _emailController, emailvalidate: _emailvalidate),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: PasswordInputWidget(passController: _passController, obscured: _obscured, textFieldFocusNode: textFieldFocusNode, passvalidate: _passvalidate),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 28, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(AppColors.colorYellow),
                                minimumSize: const Size(100, 52),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(8), // <-- Radius
                                ),
                              ),
                              child: Text(
                                AppStrings.loginButtonText,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_emailController.text.isEmpty) {
                                    _emailvalidate = true;
                                  } else {
                                    if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(_emailController.text)) {
                                      _emailvalidate = true;
                                    } else {
                                      if (_passController.text.isEmpty ||
                                          _passController.text.length < 8) {
                                        _passvalidate = true;
                                      } else {
                                        _emailvalidate = false;
                                        _passvalidate = false;

                                        _navigateToDashboardScreen(context);



                                        // _authUser(_emailController.text,
                                        //     _passController.text, context);
                                      }
                                    }
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            )

        )
    );

  }
}



void _navigateToDashboardScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainHome()));
}
