import 'package:flutter/material.dart';

class AppBarLocationText extends StatelessWidget {
  const AppBarLocationText({
    super.key,
    required this.locationText,
  });

  final String locationText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text("Current Location : ",
          style:  TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),),
        Text(locationText,
          style:  const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),)
      ],
    );
  }
}