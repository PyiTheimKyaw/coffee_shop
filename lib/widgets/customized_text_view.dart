import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';

class CustomizedTextView extends StatelessWidget {
  const CustomizedTextView({
    super.key,
    required this.textData,
    this.textFontSize = AppDimens.kFont14,
    this.textColor = AppColors.kBlackColor,
    this.textFontWeight = FontWeight.w400,
    this.textAlign = TextAlign.start,
    this.textDecoration,
    this.textHeight,
    this.letterSpacing,
    this.overflow,
  });

  final String textData;
  final double? textFontSize;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final double? textHeight;
  final double? letterSpacing;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      textData,
      style: TextStyle(
        fontSize: textFontSize,
        color: textColor,
        fontWeight: textFontWeight,
        height: textHeight,
        letterSpacing: letterSpacing,
        overflow: overflow,
        decoration: textDecoration,
        decorationStyle: TextDecorationStyle.solid,
      ),
      textAlign: textAlign,
    );
  }
}
