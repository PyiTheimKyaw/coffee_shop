import 'package:coffee_shop/utils/images.dart';
import 'package:coffee_shop/utils/responsive.dart';
import 'package:coffee_shop/widgets/ghost_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/route_constants.dart';
import '../utils/strings.dart';
import '../widgets/customized_text_view.dart';
import '../widgets/primary_button.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kAppBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.kAppBgColor,
        centerTitle: true,
        elevation: 0,
        //Back icon
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
            child: Icon(Icons.arrow_back_ios, size: AppDimens.kBackIconSize),
          ),
        ),
        //Detail title
        title: CustomizedTextView(
          textData: kTextOrder,
          textFontWeight: FontWeight.w600,
          textFontSize: AppDimens.kFont16,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppDimens.kOrderTabOptionHeight),
          child: Responsive(mobile: _OptionTabView(), tablet: _OptionTabView(isTablet: true)),
        ),
      ),
      body: Responsive(
        mobile: _ResponsiveOrderPageView(),
        tablet: _ResponsiveOrderPageView(isTablet: true),
      ),
      bottomNavigationBar: Responsive(
        mobile: _OrderBtnSectionView(),
        tablet: _OrderBtnSectionView(isTablet: true),
      ),
    );
  }
}

class _OrderBtnSectionView extends StatelessWidget {
  const _OrderBtnSectionView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.kMargin24),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimens.kRadius20),
          topRight: Radius.circular(AppDimens.kRadius20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.credit_card_sharp,
                size: AppDimens.kMediumIconSize,
                color: AppColors.kPrimaryColor,
              ),
              SizedBox(width: AppDimens.kMargin16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomizedTextView(
                      textData: kTextCashOrWallet,
                      textFontWeight: FontWeight.w600,
                    ),
                    SizedBox(height: AppDimens.kMargin4),
                    CustomizedTextView(
                      textData: "\$4.05",
                      textColor: AppColors.kPrimaryColor,
                      textFontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Icon(Icons.expand_more_outlined, size: AppDimens.kMediumIconSize),
            ],
          ),
          SizedBox(height: AppDimens.kMargin24),
          PrimaryButton(
            btnText: kTextOrder,
            onTapBtn: () {
              context.pushNamed(RouteConstants.kRouteOrder);
            },
            btnHeight:
                (isTablet ?? false)
                    ? AppDimens.kDetailBuyBtnTabletSize
                    : AppDimens.kDetailBuyBtnMobileSize,
          ),
        ],
      ),
    );
  }
}

class _ResponsiveOrderPageView extends StatelessWidget {
  const _ResponsiveOrderPageView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimens.kMargin24),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DeliveryAddressAndProductItemSectionView(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.kMargin12),
              child: Divider(color: AppColors.kPrimaryColor.withValues(alpha: 0.2), thickness: 3),
            ),
            _PaymentSummarySectionView(isTablet: isTablet),
          ],
        ),
      ),
    );
  }
}

class _PaymentSummarySectionView extends StatelessWidget {
  const _PaymentSummarySectionView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width:
                  (isTablet ?? false) ? MediaQuery.of(context).size.width * 0.5 : double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: AppDimens.kMargin12,
                horizontal: AppDimens.kMargin16,
              ),
              decoration: BoxDecoration(
                color: AppColors.kWhiteColor,
                border: Border.all(color: AppColors.kLightGreyColor),
                borderRadius: BorderRadius.circular(AppDimens.kRadius16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.energy_savings_leaf,
                    size: AppDimens.kMediumIconSize,
                    color: AppColors.kPrimaryColor,
                  ),
                  SizedBox(width: AppDimens.kMargin12),
                  Expanded(
                    child: CustomizedTextView(
                      textData: "1 discount is applies",
                      textFontWeight: FontWeight.w600,
                      textFontSize: AppDimens.kFont16,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: AppDimens.kMediumIconSize),
                ],
              ),
            ),
          ),
          SizedBox(height: AppDimens.kMargin24),
          CustomizedTextView(
            textData: kTextPaymentSummary,
            textFontSize: AppDimens.kFont16,
            textFontWeight: FontWeight.w600,
          ),
          SizedBox(height: AppDimens.kMargin16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomizedTextView(textData: kTextPrice),

              CustomizedTextView(textData: "\$ 4.04", textFontWeight: FontWeight.w500),
            ],
          ),
          SizedBox(height: AppDimens.kMargin8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomizedTextView(textData: kTextDeliveryFee),

              CustomizedTextView(textData: "\$ 4.04", textFontWeight: FontWeight.w500),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeliveryAddressAndProductItemSectionView extends StatelessWidget {
  const _DeliveryAddressAndProductItemSectionView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomizedTextView(
            textData: kTextDeliveryAddress,
            textFontSize: AppDimens.kFont16,
            textFontWeight: FontWeight.w600,
          ),
          SizedBox(height: AppDimens.kMargin16),
          CustomizedTextView(
            textData: kTextDeliveryAddress,
            textFontSize: AppDimens.kFont14,
            textFontWeight: FontWeight.w600,
          ),
          CustomizedTextView(
            textData: kTextDeliveryAddress,
            textFontSize: AppDimens.kFont12,
            textColor: AppColors.kGreyColor,
          ),
          SizedBox(height: AppDimens.kMargin16),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWithIconAndText(btnLabel: kTextEditAddress, icon: Icons.edit),
              SizedBox(width: AppDimens.kMargin12),
              ButtonWithIconAndText(btnLabel: kTextAddNote, icon: Icons.event_note),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimens.kMargin16,
              vertical: AppDimens.kMargin12,
            ),
            child: Divider(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.kRadius12),
                child: Image.asset(
                  AppImages.kDummyDetailBG,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: AppDimens.kMargin16),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomizedTextView(
                      textData: "Caffee Mocha",
                      textFontWeight: FontWeight.w600,
                      textFontSize: AppDimens.kFont14,
                    ),
                    CustomizedTextView(
                      textData: "Caffee Mocha",
                      textFontSize: AppDimens.kFont12,
                      textColor: AppColors.kGreyColor,
                      textFontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      color: AppColors.kWhiteColor,
                      child: Icon(
                        Icons.remove,
                        color: AppColors.kGreyColor,
                        size: AppDimens.kMediumIconSize,
                      ),
                    ),
                    SizedBox(width: AppDimens.kMargin16),
                    CustomizedTextView(textData: "1", textFontWeight: FontWeight.w600),
                    SizedBox(width: AppDimens.kMargin16),

                    Card(
                      elevation: 1,
                      color: AppColors.kWhiteColor,
                      child: Icon(Icons.add, size: AppDimens.kMediumIconSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionTabView extends StatelessWidget {
  const _OptionTabView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
      width: (isTablet ?? false) ? MediaQuery.of(context).size.width * 0.6 : double.infinity,
      padding: EdgeInsets.all(AppDimens.kMargin4),
      decoration: BoxDecoration(
        color: AppColors.kTabBgColor,
        borderRadius: BorderRadius.circular(AppDimens.kRadius10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _TabView(tabLabel: kTextDeliver, isSelected: true)),
          Expanded(child: _TabView(tabLabel: kTextPickUp)),
        ],
      ),
    );
  }
}

class _TabView extends StatelessWidget {
  const _TabView({required this.tabLabel, this.isSelected = false});

  final String tabLabel;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.kMargin24, vertical: AppDimens.kMargin10),
      decoration: BoxDecoration(
        color: (isSelected ?? false) ? AppColors.kPrimaryColor : null,
        borderRadius: BorderRadius.circular(AppDimens.kRadius10),
      ),
      child: Center(
        child: CustomizedTextView(
          textData: tabLabel,
          textFontWeight: (isSelected ?? false) ? FontWeight.w600 : FontWeight.w400,
          textFontSize: AppDimens.kFont14,
          textColor: (isSelected ?? false) ? AppColors.kWhiteColor : AppColors.kBlackColor,
        ),
      ),
    );
  }
}
