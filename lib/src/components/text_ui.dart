import 'package:flutter/material.dart';
import 'package:walletconnect_qrcode_modal_dart/src/lib/config/cnp_app_color.dart';

class TextUI extends StatelessWidget {
  final String textString;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  const TextUI({
    Key? key,
    required this.textString,
    this.fontSize = 16.0,
    this.fontColor = CnpAppColor.black,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textString,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      ),
    );
  }
}
