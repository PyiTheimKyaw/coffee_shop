import 'package:coffee_shop/bloc/index_page_bloc.dart';
import 'package:coffee_shop/pages/bookmarks_page.dart';
import 'package:coffee_shop/pages/cart_page.dart';
import 'package:coffee_shop/pages/home_page.dart';
import 'package:coffee_shop/pages/noti_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget getPage(int index) {
      switch (index) {
        case 0:
          return HomePage();
        case 1:
          return BookmarksPage();
        case 2:
          return CartPage();
        default:
          return NotiPage();
      }
    }

    return ChangeNotifierProvider(
      create: (BuildContext context) => IndexPageBloc(),
      child: Selector<IndexPageBloc, int>(
        selector: (BuildContext context, bloc) => bloc.index,
        builder:
            (BuildContext context, pageIndex, Widget? child) => SafeArea(
              child: Scaffold(
                body: getPage(pageIndex),
                bottomNavigationBar: SizedBox(
                  height: kBottomNavigationBarHeight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NavigationBarItemView(
                        icon: Icons.home,
                        index: 0,
                        isSelected: pageIndex == 0,
                        onTapIndex: (index) {
                          final bloc = Provider.of<IndexPageBloc>(context, listen: false);
                          bloc.onChangedIndex(index);
                        },
                      ),
                      _NavigationBarItemView(
                        icon: Icons.favorite_border,
                        index: 1,
                        isSelected: pageIndex == 1,
                        onTapIndex: (index) {
                          final bloc = Provider.of<IndexPageBloc>(context, listen: false);
                          bloc.onChangedIndex(index);
                        },
                      ),
                      _NavigationBarItemView(
                        icon: Icons.shopping_cart_rounded,
                        index: 2,
                        isSelected: pageIndex == 2,
                        onTapIndex: (index) {
                          final bloc = Provider.of<IndexPageBloc>(context, listen: false);
                          bloc.onChangedIndex(index);
                        },
                      ),
                      _NavigationBarItemView(
                        icon: Icons.notifications_none,
                        index: 3,
                        isSelected: pageIndex == 3,
                        onTapIndex: (index) {
                          final bloc = Provider.of<IndexPageBloc>(context, listen: false);
                          bloc.onChangedIndex(index);
                        },
                      ),
                    ],
                  ),
                ),
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
          width: double.infinity,
          height: double.infinity,
          color: AppColors.kWhiteColor,
          duration: Duration(milliseconds: 200),
          child: Center(
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
      ),
    );
  }
}
