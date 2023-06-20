import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({
    super.key,
    required TextEditingController emailController,
    required bool emailvalidate,
  }) : _emailController = emailController, _emailvalidate = emailvalidate;

  final TextEditingController _emailController;
  final bool _emailvalidate;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _emailController,
      style: TextStyle(
        color: Color(AppColors.colorWhite),
        fontSize: 14,
      ),
      decoration: InputDecoration(
        errorText: _emailvalidate
            ? 'Please enter a valid email address.'
            : null,
        hintText: AppStrings.hintTextEmail,
        hintStyle: TextStyle(
          color: Color(AppColors.colorGray3),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Color(AppColors.colorBlue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
