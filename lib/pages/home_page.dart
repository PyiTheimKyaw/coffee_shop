import 'package:coffee_shop/utils/colors.dart';
import 'package:coffee_shop/utils/responsive.dart';
import 'package:coffee_shop/widgets/customized_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/dimens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.kAppBgColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: AppColors.kHomePageHeaderBgColor,
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
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
                minHeight: 70,
                maxHeight: 70,
                child: const _StatusSectionView(),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: AppDimens.kMargin16),
                  color: Colors.red,
                );
              }, childCount: 10),
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
    final headerHeight = screenHeight * 0.3;
    final promoCardHeight = 150.0;
    final promoTop = headerHeight - (promoCardHeight / 2);
    return Stack(
      children: [
        Container(
          height: headerHeight,
          color: AppColors.kHomePageHeaderBgColor,
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
    return Container(
      padding: const EdgeInsets.only(
        top: AppDimens.kMargin12,
        bottom: AppDimens.kMargin8,
      ),
      height: 70,
      color: Colors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
        itemBuilder: (context, index) {
          return _OptionItemView(isSelected: true,);
        },
        separatorBuilder:
            (context, index) => const SizedBox(width: AppDimens.kMargin8),
        itemCount: 10,
      ),
    );
  }
}

class _OptionItemView extends StatelessWidget {
  const _OptionItemView({this.isSelected = false});

  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.kMargin8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimens.kRadius10),
        color:
            (isSelected ?? false)
                ? AppColors.kPrimaryColor
                : AppColors.kLightGreyColor,
      ),
      child: Center(
        child: CustomizedTextView(
          textData: "textData",
          textColor:
              (isSelected ?? false)
                  ? AppColors.kWhiteColor
                  : AppColors.kBlackColor,
        ),
      ),
    );
  }
}

class _CustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _CustomHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
