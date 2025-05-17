import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'customized_text_view.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.btnText,
    this.btnTextFontSize = AppDimens.kFont16,
    this.btnTextColor = AppColors.kWhiteColor,
    this.isActive = true,
    required this.onTapBtn,
    this.boxShadow,
    this.isDense = false,
    this.btnWidth,
    this.btnHeight,
  });

  final String btnText;
  final double? btnTextFontSize;
  final Color? btnTextColor;
  final bool? isActive;
  final VoidCallback onTapBtn;
  final BoxShadow? boxShadow;
  final bool? isDense;
  final double? btnWidth;
  final double? btnHeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapBtn();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.kMargin12),
        width:(btnWidth!=null)? btnWidth : (isDense ?? false) ? null : double.infinity,
        height: btnHeight,
        decoration: ShapeDecoration(
          color: AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadows: boxShadow != null ? [boxShadow!] : [],
        ),
        child: Center(
          child: CustomizedTextView(
            textData: btnText,
            textFontSize: btnTextFontSize,
            textColor: btnTextColor,
            textFontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
