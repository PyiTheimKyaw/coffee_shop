import 'package:coffee_shop/bloc/home_page_bloc.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';
import 'package:coffee_shop/utils/colors.dart';
import 'package:coffee_shop/utils/images.dart';
import 'package:coffee_shop/utils/responsive.dart';
import 'package:coffee_shop/utils/route_constants.dart';
import 'package:coffee_shop/utils/strings.dart';
import 'package:coffee_shop/widgets/customized_text_view.dart';
import 'package:coffee_shop/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../utils/dimens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomePageBloc(),
      child: Consumer<HomePageBloc>(
        builder:
            (BuildContext context, bloc, Widget? child) =>
                (bloc.coffeeListByCategory.isNotEmpty)
                    ? CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: AppColors.kAppBgColor,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarIconBrightness: Brightness.light,
                            statusBarColor: AppColors.kHomePageHeaderBgColor,
                          ),
                          expandedHeight:
                              (Responsive.isSmallMobile(context))
                                  ? MediaQuery.of(context).size.height * 0.5
                                  : MediaQuery.of(context).size.height * 0.4,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Responsive(
                              mobile: _SearchBarAndBannerSectionView(),
                              tablet: _SearchBarAndBannerSectionView(isTablet: true),
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _CustomHeaderDelegate(
                            minHeight: 50,
                            maxHeight: 50,
                            child: const _StatusSectionView(),
                          ),
                        ),
                        Responsive(
                          mobile: SliverPadding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.kMargin24,
                              vertical: AppDimens.kMargin12,
                            ),
                            sliver: SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: AppDimens.kMargin12,
                                crossAxisSpacing: AppDimens.kMargin8,
                                childAspectRatio: 0.7,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    _ProductItemView(coffee: bloc.coffeeListByCategory[index]),
                                childCount: bloc.coffeeListByCategory.length,
                              ),
                            ),
                          ),
                          tablet: SliverPadding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppDimens.kMargin24,
                              vertical: AppDimens.kMargin12,
                            ),
                            sliver: SliverGrid(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: AppDimens.kMargin12,
                                crossAxisSpacing: AppDimens.kMargin8,
                                childAspectRatio: 1,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) =>
                                    _ProductItemView(coffee: bloc.coffeeListByCategory[index]),
                                childCount: bloc.coffeeListByCategory.length,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _ProductItemView extends StatelessWidget {
  const _ProductItemView({required this.coffee});

  final CoffeeVO? coffee;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteConstants.kRouteDetails, extra: coffee);
      },
      child: Container(
        padding: EdgeInsets.all(AppDimens.kMargin8),
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(AppDimens.kRadius12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimens.kRadius12),
                child: Stack(
                  children: [
                    Image.asset(
                      AppImages.kDummyDetailBG,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimens.kMargin8,
                          vertical: AppDimens.kMargin8,
                        ),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(AppDimens.kRadius30),
                            ),
                          ),
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.kPrimaryColor,
                              size: AppDimens.kSmallIconSize,
                            ),
                            CustomizedTextView(
                              textData: coffee?.rating.toString() ?? "",
                              textColor: AppColors.kWhiteColor,
                              textFontSize: AppDimens.kFont10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppDimens.kMargin8),
            CustomizedTextView(
              textData: coffee?.name ?? "",
              overflow: TextOverflow.ellipsis,
              textFontWeight: FontWeight.w600,
              textFontSize: AppDimens.kFont14,
            ),
            SizedBox(height: AppDimens.kMargin4),

            CustomizedTextView(
              textData: coffee?.category ?? "",
              overflow: TextOverflow.ellipsis,
              textFontSize: AppDimens.kFont12,
              textColor: AppColors.kGreyColor,
              textFontWeight: FontWeight.w500,
            ),
            SizedBox(height: AppDimens.kMargin8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomizedTextView(
                  textData: "\$ ${coffee?.price.first.amount}",
                  textFontWeight: FontWeight.w600,
                  textFontSize: AppDimens.kFont16,
                ),

                PrimaryButton(
                  onTapBtn: () {},
                  isDense: true,
                  btnRadius: AppDimens.kRadius10,
                  btnIcon: Icon(Icons.add, color: AppColors.kWhiteColor),
                  isIconOnly: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchBarAndBannerSectionView extends StatelessWidget {
  const _SearchBarAndBannerSectionView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    // Heights
    final headerHeight =
        (Responsive.isSmallMobile(context)) ? screenHeight * 0.4 : screenHeight * 0.3;
    final promoCardHeight = (Responsive.isSmallMobile(context)) ? 120.0 : 150.0;
    final promoTop = headerHeight - (promoCardHeight / 2);
    return Stack(
      children: [
        Container(
          // padding: EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
          height: headerHeight,
          color: AppColors.kHomePageHeaderBgColor,
          padding: EdgeInsets.only(
            top: (isTablet ?? false) ? AppDimens.kMargin50 : AppDimens.kMargin30,
            left: AppDimens.kMargin24,
            right: AppDimens.kMargin24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedTextView(
                textData: "Location",
                textColor: AppColors.kGreyColor,
                textFontSize: AppDimens.kFont14,
              ),
              SizedBox(height: AppDimens.kMargin4),
              CustomizedTextView(
                textData: "Bilzen, Tanjungbalai",
                textColor: AppColors.kWhiteColor,
                textFontSize: AppDimens.kFont18,
                textFontWeight: FontWeight.bold,
              ),
              SizedBox(height: AppDimens.kMargin20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.white54),
                          SizedBox(width: 10),
                          Text("Search coffee", style: TextStyle(color: Colors.white54)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFdd855d),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.tune, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: promoTop,
          left: (isTablet ?? false) ? 100 : 20,
          right: (isTablet ?? false) ? 100 : 20,
          child: Container(
            height: promoCardHeight,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(AppDimens.kRadius20),
              image: DecorationImage(
                image: AssetImage("assets/images/dummy_2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusSectionView extends StatelessWidget {
  const _StatusSectionView();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Container(
            padding: const EdgeInsets.only(top: AppDimens.kMargin12, bottom: AppDimens.kMargin8),
            height: 50,
            color: AppColors.kAppBgColor,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _OptionItemView(
                    optionLabel: kTextAllCoffee,
                    isSelected: bloc.selectedCategory == kTextAllCoffee,
                    onChooseCategory: () {
                      bloc.onChooseCategory(kTextAllCoffee);
                    },
                  );
                } else {
                  final category = bloc.categories?[index - 1] ?? "";
                  return _OptionItemView(
                    optionLabel: category,
                    isSelected: bloc.selectedCategory == category,
                    onChooseCategory: () {
                      bloc.onChooseCategory(category);
                    },
                  );
                }
              },
              separatorBuilder: (context, index) => const SizedBox(width: AppDimens.kMargin8),
              itemCount: (bloc.categories?.length ?? 0) + 1,
            ),
          ),
    );
  }
}

class _OptionItemView extends StatelessWidget {
  const _OptionItemView({
    this.isSelected = false,
    required this.optionLabel,
    required this.onChooseCategory,
  });

  final bool? isSelected;
  final String optionLabel;
  final VoidCallback onChooseCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChooseCategory();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppDimens.kMargin8, vertical: AppDimens.kMargin4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.kRadius10),
          color: (isSelected ?? false) ? AppColors.kPrimaryColor : AppColors.kLightGreyColor,
        ),
        child: Center(
          child: CustomizedTextView(
            textData: optionLabel,
            textColor: (isSelected ?? false) ? AppColors.kWhiteColor : AppColors.kBlackColor,
          ),
        ),
      ),
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _CustomHeaderDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
