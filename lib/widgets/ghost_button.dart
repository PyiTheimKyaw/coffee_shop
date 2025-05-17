import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'customized_text_view.dart';

class ButtonWithIconAndText extends StatelessWidget {
  const ButtonWithIconAndText({
    super.key,
    required this.btnLabel,
    required this.icon,
    this.btnTextFontSize= AppDimens.kFont12,
  });
  final String btnLabel;
  final IconData icon;
  final double? btnTextFontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimens.kMargin8,
        vertical: AppDimens.kMargin4,
      ),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        border: Border.all(color: AppColors.kEditAddressAndAddNoteBtnBorderColor),
        borderRadius: BorderRadius.circular(AppDimens.kRadius20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,size: AppDimens.kSmallIconSize,),
          SizedBox(width: AppDimens.kMargin4,),
          CustomizedTextView(textData: btnLabel,textFontSize: btnTextFontSize,),
        ],
      ),
    );
  }
}
