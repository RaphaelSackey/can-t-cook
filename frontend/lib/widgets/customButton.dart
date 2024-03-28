import 'package:cantcook/utils/colours.dart';
import 'package:cantcook/widgets/customText.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColour,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
        ),
        onPressed: onPressed,
        child: CustomText(text: text, color: Colors.white),
      ),
    );
  }
}
