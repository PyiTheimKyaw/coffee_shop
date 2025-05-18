import 'package:coffee_shop/pages/home_page.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HomePage(),
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _NavigationBarItemView(
                icon: Icons.home,
                index: 0,
                isSelected: true,
                onTapIndex: (index) {},
              ),
              _NavigationBarItemView(icon: Icons.favorite_border, index: 1, onTapIndex: (index) {}),
              _NavigationBarItemView(
                icon: Icons.shopping_cart_rounded,
                index: 2,
                onTapIndex: (index) {},
              ),
              _NavigationBarItemView(
                icon: Icons.notifications_none,
                index: 3,
                onTapIndex: (index) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationBarItemView extends StatelessWidget {
  const _NavigationBarItemView({
    this.isSelected = false,
    required this.icon,
    required this.index,
    required this.onTapIndex,
  });

  final IconData icon;
  final int index;
  final bool? isSelected;
  final Function(int) onTapIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTapIndex(index);
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: AppDimens.kBottomNavIconSize,
                color: (isSelected ?? false) ? AppColors.kPrimaryColor : AppColors.kGreyColor,
              ),

              Visibility(
                visible: isSelected ?? false,
                child: Container(
                  height: 5,
                  width: 10,
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor,
                    borderRadius: BorderRadius.circular(AppDimens.kRadius30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
