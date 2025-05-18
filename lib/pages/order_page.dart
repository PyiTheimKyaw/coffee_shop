import 'package:coffee_shop/bloc/order_page_bloc.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';
import 'package:coffee_shop/utils/images.dart';
import 'package:coffee_shop/utils/responsive.dart';
import 'package:coffee_shop/widgets/ghost_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import '../utils/route_constants.dart';
import '../utils/strings.dart';
import '../widgets/customized_text_view.dart';
import '../widgets/primary_button.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, this.coffee, this.price});

  final double? price;
  final CoffeeVO? coffee;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => OrderPageBloc(coffee: coffee, itemPrice: price),
      child: Selector<OrderPageBloc, String>(
        selector: (BuildContext context, bloc) => bloc.chosenTab,
        builder:
            (BuildContext context, chosenTab, Widget? child) => Scaffold(
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
                  child: Responsive(
                    mobile: _OptionTabView(),
                    tablet: _OptionTabView(isTablet: true),
                  ),
                ),
              ),
              body:
                  (chosenTab == kTextDeliver)
                      ? Responsive(
                        mobile: _ResponsiveOrderPageView(),
                        tablet: _ResponsiveOrderPageView(isTablet: true),
                      )
                      : Responsive(mobile: _PickUpSectionView(), tablet: _PickUpSectionView()),
              bottomNavigationBar: Responsive(
                mobile: _OrderBtnSectionView(),
                tablet: _OrderBtnSectionView(isTablet: true),
              ),
            ),
      ),
    );
  }
}

class _PickUpSectionView extends StatelessWidget {
  const _PickUpSectionView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [CustomizedTextView(textData: "Coming Soon")],
      ),
    );
  }
}

class _OrderBtnSectionView extends StatelessWidget {
  const _OrderBtnSectionView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderPageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Container(
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
                            textData:
                                (bloc.priceForAll == 0)
                                    ? "\$ 0"
                                    : "\$ ${(bloc.priceForAll ?? 0) + bloc.deliFee}",
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
                  isActive: bloc.chosenCount != 0,
                  onTapBtn: () {
                    context.pushNamed(RouteConstants.kRouteOrderTrackPage);
                  },
                  btnHeight:
                      (isTablet ?? false)
                          ? AppDimens.kDetailBuyBtnTabletSize
                          : AppDimens.kDetailBuyBtnMobileSize,
                ),
              ],
            ),
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
    return Consumer<OrderPageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width:
                        (isTablet ?? false)
                            ? MediaQuery.of(context).size.width * 0.5
                            : double.infinity,
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
                          size: AppDimens.kSmallIconSize,
                          color: AppColors.kPrimaryColor,
                        ),
                        SizedBox(width: AppDimens.kMargin12),
                        Expanded(
                          child: CustomizedTextView(
                            textData: kTextDummyDiscount,
                            textFontWeight: FontWeight.w600,
                            textFontSize: AppDimens.kFont16,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, size: AppDimens.kSmallIconSize),
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

                    CustomizedTextView(
                      textData: "\$ ${bloc.priceForAll ?? bloc.pricePerOne}",
                      textFontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: AppDimens.kMargin8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomizedTextView(textData: kTextDeliveryFee),
                    Row(
                      children: [
                        ///TODO: bind with real discount data
                        CustomizedTextView(
                          textData: "\$ 2.0",
                          textDecoration: TextDecoration.lineThrough,
                        ),
                        SizedBox(width: AppDimens.kMargin16),
                        CustomizedTextView(
                          textData: "\$ ${bloc.deliFee}",
                          textFontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
            textData: kTextDummyCustomerName,
            textFontSize: AppDimens.kFont14,
            textFontWeight: FontWeight.w600,
          ),
          CustomizedTextView(
            textData: kTextDummyCustomerAddress,
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
          _ChosenProductItemView(),
        ],
      ),
    );
  }
}

class _ChosenProductItemView extends StatelessWidget {
  const _ChosenProductItemView();

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderPageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.kRadius12),
                child: Image.asset(
                  AppImages.kDummyDetailBG,
                  width: AppDimens.kOrderChosenItemImgSize,
                  height: AppDimens.kOrderChosenItemImgSize,
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
                      textData: bloc.chosenCoffee?.name ?? "",
                      textFontWeight: FontWeight.w600,
                      textFontSize: AppDimens.kFont14,
                    ),
                    CustomizedTextView(
                      textData: bloc.chosenCoffee?.category ?? "",
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
                    InkWell(
                      onTap: () {
                        bloc.onTapDecreaseCount();
                      },
                      child: Card(
                        color: AppColors.kWhiteColor,
                        child: Icon(
                          Icons.remove,
                          color: AppColors.kGreyColor,
                          size: AppDimens.kMediumIconSize,
                        ),
                      ),
                    ),
                    SizedBox(width: AppDimens.kMargin16),
                    CustomizedTextView(
                      textData: bloc.chosenCount.toString(),
                      textFontWeight: FontWeight.w600,
                    ),
                    SizedBox(width: AppDimens.kMargin16),

                    InkWell(
                      onTap: () {
                        bloc.onTapIncreaseCount();
                      },
                      child: Card(
                        elevation: 1,
                        color: AppColors.kWhiteColor,
                        child: Icon(Icons.add, size: AppDimens.kMediumIconSize),
                      ),
                    ),
                  ],
                ),
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
    return Consumer<OrderPageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Container(
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
                Expanded(
                  child: _TabView(
                    tabLabel: kTextDeliver,
                    isSelected: bloc.chosenTab == kTextDeliver,
                    onChooseTab: () {
                      bloc.onChooseTab(selectedTab: kTextDeliver);
                    },
                  ),
                ),
                Expanded(
                  child: _TabView(
                    tabLabel: kTextPickUp,
                    isSelected: bloc.chosenTab == kTextPickUp,
                    onChooseTab: () {
                      bloc.onChooseTab(selectedTab: kTextPickUp);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class _TabView extends StatelessWidget {
  const _TabView({required this.tabLabel, this.isSelected = false, required this.onChooseTab});

  final String tabLabel;
  final bool? isSelected;
  final VoidCallback onChooseTab;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChooseTab();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: AppDimens.kMargin24,
          vertical: AppDimens.kMargin10,
        ),
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
      ),
    );
  }
}
