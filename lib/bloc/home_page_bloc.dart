import 'package:coffee_shop/bloc/base_bloc.dart';
import 'package:coffee_shop/data/models/static_data_model.dart';
import 'package:coffee_shop/data/models/static_data_model_impl.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';

import '../utils/strings.dart';

class HomePageBloc extends BaseBloc {
  String selectedCategory = kTextAllCoffee;
  List<String>? categories;
  List<CoffeeVO>? coffeeList;
  List<CoffeeVO> coffeeListByCategory = [];
  final StaticDataModel _staticDataModel = StaticDataModelImpl();

  HomePageBloc() {
    getAllCategories();
    getAllCoffeeList();
  }

  void onChooseCategory(String selectedValue) {
    selectedCategory = selectedValue;

    coffeeListByCategory.clear();

    if (selectedValue == kTextAllCoffee) {
      coffeeListByCategory.addAll(coffeeList ?? []);
    } else {
      final filteredList =
          coffeeList?.where((coffee) => coffee.category == selectedValue).toList() ?? [];

      coffeeListByCategory.addAll(filteredList);
    }

    notifySafely();
  }

  Future<List<CoffeeVO>?> getAllCoffeeList() {
    return _staticDataModel.getAllCoffeeList().then((list) {
      coffeeList = list;
      coffeeListByCategory.addAll(list ?? []);
      notifySafely();
      return coffeeList;
    });
  }

  Future<List<String>?> getAllCategories() {
    return _staticDataModel.getAllCategories().then((list) {
      categories = list;
      notifySafely();
      return categories;
    });
  }
}
