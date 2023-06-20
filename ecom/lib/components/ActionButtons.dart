import 'package:ecom/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  ActionButton({
    Key? key,
    required this.btnTitle,
    required this.onClick,
  }) : super(key: key);

  final Function() onClick;
  final String btnTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(120, 52),
        primary: Color(AppColors.actionBtnColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // <-- Radius
        ),
      ),
      onPressed: onClick,
      child: Text(
        btnTitle,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Color(AppColors.colorWhite),
        ),
      ),
    );
  }
}