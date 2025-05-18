import 'package:coffee_shop/utils/colors.dart';
import 'package:coffee_shop/utils/dimens.dart';
import 'package:coffee_shop/utils/images.dart';
import 'package:coffee_shop/utils/responsive.dart';
import 'package:coffee_shop/utils/route_constants.dart';
import 'package:coffee_shop/utils/strings.dart';
import 'package:coffee_shop/widgets/customized_text_view.dart';
import 'package:coffee_shop/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _OnBoardingResponsiveView(),
      tablet: _OnBoardingResponsiveView(isTablet: true),
    );
  }
}

class _OnBoardingResponsiveView extends StatelessWidget {
  const _OnBoardingResponsiveView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(child: Image.asset(AppImages.kOnBoardingImg, fit: BoxFit.cover)),

          // Content overlay
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
              margin: EdgeInsets.symmetric(vertical: AppDimens.kMargin40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.2)],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Title
                  const CustomizedTextView(
                    textData: kTextOnBoardingTitle,
                    textAlign: TextAlign.center,
                    textFontSize: AppDimens.kFont28,
                    textFontWeight: FontWeight.bold,
                    textColor: AppColors.kWhiteColor,
                  ),
                  const SizedBox(height: AppDimens.kMargin16),
                  //Desc
                  CustomizedTextView(
                    textData: kTextOnBoardingDesc,
                    textAlign: TextAlign.center,
                    textColor: AppColors.kOnBoardingDescTextColor,
                  ),
                  const SizedBox(height: AppDimens.kMargin30),
                  //Get Started Button
                  PrimaryButton(
                    btnText: kTextGetStarted,
                    btnHeight: AppDimens.kGetStartedBtnHeight,
                    isDense: isTablet ?? false,
                    btnWidth: (isTablet ?? false) ? MediaQuery.of(context).size.width / 1.5 : null,

                    onTapBtn: () {
                      //navigate to home page
                      context.goNamed(RouteConstants.kRouteIndex);
                    },
                    btnTextColor: AppColors.kWhiteColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
