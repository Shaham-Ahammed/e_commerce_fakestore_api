import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont extends StatelessWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextOverflow? overflow;
  const AppFont(this.text,
      {this.fontWeight = FontWeight.normal,
      this.color = Colors.black,
      this.overflow,
      this.size = 14,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.actor(
        textStyle: TextStyle(
          overflow: overflow,
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
