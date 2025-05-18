import 'package:coffee_shop/bloc/base_bloc.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';
import 'package:coffee_shop/utils/strings.dart';

class OrderPageBloc extends BaseBloc {
  String chosenTab = kTextDeliver;
  CoffeeVO? chosenCoffee;
  double? pricePerOne;
  double? priceForAll;
  int chosenCount = 1;

  ///TODO: bind with real data later
  double deliFee = 1.5;

  OrderPageBloc({CoffeeVO? coffee, double? itemPrice}) {
    chosenCoffee = coffee;
    pricePerOne = itemPrice;
    notifySafely();
  }

  void onTapDecreaseCount() {
    if ((chosenCount) > 0) {
      chosenCount--;
      priceForAll = (pricePerOne ?? 0) * chosenCount;
      notifySafely();
    }
  }

  void onTapIncreaseCount() {
    chosenCount++;
    priceForAll = (pricePerOne ?? 0) * chosenCount;
    notifySafely();
  }

  void onChooseTab({required String selectedTab}) {
    chosenTab = selectedTab;
    notifySafely();
  }
}
