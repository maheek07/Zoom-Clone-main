import 'package:flutter/material.dart';
import 'package:zoom_meet/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          minimumSize: const Size(double.infinity, 50),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
            side: BorderSide(color: buttonColor),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, color: Colors.white),
        ),
      ),
    );
  }
}
