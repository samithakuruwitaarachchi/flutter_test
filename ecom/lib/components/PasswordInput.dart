import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({
    super.key,
    required TextEditingController passController,
    required bool obscured,
    required this.textFieldFocusNode,
    required bool passvalidate,
  }) : _passController = passController, _obscured = obscured, _passvalidate = passvalidate;

  final TextEditingController _passController;
  final bool _obscured;
  final FocusNode textFieldFocusNode;
  final bool _passvalidate;



  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _passController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscured,
      focusNode: textFieldFocusNode,
      obscuringCharacter: "*",
      style: TextStyle(
        color: Color(AppColors.colorWhite),
        fontSize: 14,
      ),
      decoration: InputDecoration(
        errorText: _passvalidate
            ? 'Please enter a correct password.'
            : null,
        hintText: AppStrings.hintPassword,
        hintStyle: TextStyle(
          color: Color(AppColors.colorGray3),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Color(AppColors.colorBlue),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 21, 0),
          child: GestureDetector(
            child: Icon(
              _obscured
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 24,
              color: Color(AppColors.colorGray1),
            ),
          ),
        ),
      ),
    );
  }
}
