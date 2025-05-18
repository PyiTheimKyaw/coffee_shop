import 'package:coffee_shop/bloc/detail_page_bloc.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';
import 'package:coffee_shop/utils/colors.dart';
import 'package:coffee_shop/utils/dimens.dart';
import 'package:coffee_shop/utils/images.dart';
import 'package:coffee_shop/utils/responsive.dart';
import 'package:coffee_shop/utils/route_constants.dart';
import 'package:coffee_shop/utils/strings.dart';
import 'package:coffee_shop/widgets/customized_text_view.dart';
import 'package:coffee_shop/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

//Detail page navigate from home page
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, this.coffee});

  final CoffeeVO? coffee;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => DetailPageBloc(coffee: coffee),
      child: Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
              child: Icon(Icons.arrow_back_ios, size: AppDimens.kBackIconSize),
            ),
          ),
          //Detail title
          title: CustomizedTextView(
            textData: kTextDetail,
            textFontWeight: FontWeight.w600,
            textFontSize: AppDimens.kFont16,
          ),
          //Action btn
          actions: [
            InkWell(
              onTap: () {
                ///TODO: to implement like action
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin24),
                child: FaIcon(FontAwesomeIcons.heart, size: AppDimens.kDetailActionIconSize),
              ),
            ),
          ],
        ),
        body: Responsive(
          mobile: _DetailPageResponsiveView(),
          tablet: _DetailPageResponsiveView(isTablet: true),
        ),
        bottomNavigationBar: Responsive(
          mobile: _BuyBtnSectionView(),
          tablet: _BuyBtnSectionView(isTablet: true),
        ),
      ),
    );
  }
}

class _DetailPageResponsiveView extends StatelessWidget {
  const _DetailPageResponsiveView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Selector<DetailPageBloc, CoffeeVO?>(
      selector: (BuildContext context, bloc) => bloc.coffeeDetail,
      builder:
          (BuildContext context, coffee, Widget? child) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppDimens.kMargin24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Item image
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height:
                          (isTablet ?? false)
                              ? MediaQuery.of(context).size.height * 0.3
                              : (MediaQuery.of(context).size.height * 0.25),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppDimens.kRadius16),
                      ),
                      child: Image.asset(AppImages.kDummyDetailBG, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: AppDimens.kMargin24),
                  //Item info Section View
                  _ItemInfoSectionView(
                    itemName: coffee?.name ?? "",
                    itemCategory: coffee?.temperature.join("/") ?? "",
                    rating: coffee?.rating.toString() ?? "0",
                  ),
                  SizedBox(height: AppDimens.kMargin8),

                  _ItemDescriptionAndSizeSectionView(isTablet: isTablet),
                ],
              ),
            ),
          ),
    );
  }
}

class _BuyBtnSectionView extends StatelessWidget {
  const _BuyBtnSectionView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimens.kMargin24,
              vertical: AppDimens.kMargin16,
            ),
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppDimens.kRadius20),
                topRight: Radius.circular(AppDimens.kRadius20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomizedTextView(
                        textData: kTextPrice,
                        textFontSize: AppDimens.kFont16,
                        textColor: AppColors.kGreyColor,
                        textFontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppDimens.kMargin4),
                      CustomizedTextView(
                        textData: "\$ ${bloc.price ?? "0"}",
                        textColor: AppColors.kPrimaryColor,
                        textFontSize: AppDimens.kFont20,
                        textFontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),

                Expanded(
                  flex: (isTablet ?? false) ? 1 : 2,
                  child: PrimaryButton(
                    btnText: kTextBuyNow,
                    onTapBtn: () {
                      context.pushNamed(RouteConstants.kRouteOrder, extra: bloc.coffeeDetail,queryParameters: {"price" : bloc.price});
                    },
                    isActive: bloc.price!=null,
                    btnHeight:
                        (isTablet ?? false)
                            ? AppDimens.kDetailBuyBtnTabletSize
                            : AppDimens.kDetailBuyBtnMobileSize,
                  ),
                ),
              ],
            ),
          ),
    );
  }
}

class _ItemDescriptionAndSizeSectionView extends StatelessWidget {
  const _ItemDescriptionAndSizeSectionView({this.isTablet = false});

  final bool? isTablet;

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPageBloc>(
      builder:
          (BuildContext context, bloc, Widget? child) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedTextView(
                textData: kTextDescription,
                textFontWeight: FontWeight.w600,
                textFontSize: AppDimens.kFont16,
              ),
              SizedBox(height: AppDimens.kMargin10),
              ReadMoreText(
                bloc.coffeeDetail?.description ?? "",
                trimMode: TrimMode.Line,
                style: TextStyle(color: AppColors.kGreyColor),
                trimLines: 3,
                colorClickableText: Colors.pink,
                trimCollapsedText: 'Read more',
                trimExpandedText: 'Read less',
                moreStyle: TextStyle(
                  fontSize: AppDimens.kFont14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kPrimaryColor,
                ),
                lessStyle: TextStyle(
                  fontSize: AppDimens.kFont14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kPrimaryColor,
                ),
              ),
              SizedBox(height: AppDimens.kDetailDescAndSizePadding),
              CustomizedTextView(
                textData: kTextSize,
                textFontWeight: FontWeight.w600,
                textFontSize: AppDimens.kFont16,
              ),
              SizedBox(height: AppDimens.kMargin10),
              Wrap(
                spacing: AppDimens.kDetailSizeSpacing,
                runSpacing: AppDimens.kDetailSizeSpacing,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: [
                  ...?bloc.coffeeDetail?.sizes.map((size) {
                    return GestureDetector(
                      onTap: () {
                        bloc.onChooseSize(chosenSize: size);
                      },
                      child: Chip(
                        label: CustomizedTextView(
                          textData: size,
                          textColor:
                              (bloc.selectedSize == size)
                                  ? AppColors.kPrimaryColor
                                  : AppColors.kBlackColor,
                        ),
                        backgroundColor:
                            (bloc.selectedSize == size)
                                ? AppColors.kLightPrimaryColor
                                : AppColors.kWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimens.kRadius12),
                          side: BorderSide(
                            color:
                                (bloc.selectedSize == size)
                                    ? AppColors.kPrimaryColor
                                    : AppColors.kGreyColor,
                          ),
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: AppDimens.kMargin30),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
    );
  }
}

class _ItemInfoSectionView extends StatelessWidget {
  const _ItemInfoSectionView({
    required this.itemName,
    required this.itemCategory,
    required this.rating,
  });

  final String itemName;
  final String itemCategory;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomizedTextView(
          textData: itemName,
          textFontSize: AppDimens.kFont20,
          textFontWeight: FontWeight.w600,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizedTextView(
              textData: itemCategory,
              textColor: AppColors.kGreyColor,
              textFontSize: AppDimens.kFont14,
            ),
            Spacer(),
            _AvailableServiceIconView(
              iconData: Icon(
                Icons.directions_bike,
                size: AppDimens.kDetailServiceIconSize,
                color: AppColors.kPrimaryColor,
              ),
            ),
            _AvailableServiceIconView(
              iconData: Icon(
                Icons.card_giftcard,
                size: AppDimens.kDetailServiceIconSize,
                color: AppColors.kPrimaryColor,
              ),
            ),
            _AvailableServiceIconView(
              iconData: Icon(
                Icons.account_tree_outlined,
                size: AppDimens.kDetailServiceIconSize,
                color: AppColors.kPrimaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: AppDimens.kMargin12),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.star, color: Colors.orange),
            CustomizedTextView(textData: rating, textFontSize: AppDimens.kFont20),
            CustomizedTextView(
              textData: "(430)",
              textColor: AppColors.kGreyColor,
              textFontSize: AppDimens.kFont12,
            ),
          ],
        ),
        SizedBox(height: AppDimens.kMargin8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimens.kMargin12),
          child: Divider(),
        ),
      ],
    );
  }
}

class _AvailableServiceIconView extends StatelessWidget {
  const _AvailableServiceIconView({required this.iconData});

  final Widget iconData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kItemDetailStatusIconColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimens.kRadius10)),
      elevation: 0,
      child: Padding(padding: const EdgeInsets.all(AppDimens.kMargin12), child: iconData),
    );
  }
}
