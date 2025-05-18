import '../vos/coffee_vo.dart';

abstract class StaticDataModel{
  Future<List<CoffeeVO>?> getAllCoffeeList();

  Future<List<String>?> getAllCategories();
}