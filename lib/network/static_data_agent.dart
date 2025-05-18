import 'package:coffee_shop/data/vos/coffee_vo.dart';

abstract class StaticDataAgent {
  Stream<List<CoffeeVO>?> getAllCoffeeList();

  Stream<List<String>?> getAllCategories();


}
