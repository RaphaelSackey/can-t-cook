import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatefulWidget {
  const CustomText(
      {required this.text,
      this.bold = false,
      this.center = false,
      this.size = 16,
      this.color = Colors.black,
      this.space = 0.8,
      this.fontFamily = "Poppins",
      Key? key})
      : super(key: key);

  final String text;
  final bool bold;
  final double size;
  final Color color;
  final double space;
  final bool center;
  final String fontFamily;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      softWrap: true,
      textAlign: widget.center ? TextAlign.center : TextAlign.left,
      style: GoogleFonts.getFont(widget.fontFamily,
          color: widget.color,
          fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
          fontSize: widget.size,
          letterSpacing: widget.space),
    );
  }
}
