import 'package:coffee_shop/bloc/base_bloc.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';

class DetailPageBloc extends BaseBloc {
  CoffeeVO? coffeeDetail;
  String? selectedSize;
  String? price;

  DetailPageBloc({CoffeeVO? coffee}) {
    coffeeDetail = coffee;
    notifySafely();
  }

  void onChooseSize({required String chosenSize}) {
    selectedSize = chosenSize;
    price =
        coffeeDetail?.price
            .where((coffee) => coffee.size == selectedSize)
            .toList()
            .first
            .amount
            .toString();
    notifySafely();
  }
}
