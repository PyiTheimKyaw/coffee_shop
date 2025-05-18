import 'package:coffee_shop/data/models/static_data_model.dart';
import 'package:coffee_shop/data/vos/coffee_vo.dart';

import '../../network/static_data_agent.dart';
import '../../network/static_data_agent_impl.dart';

class StaticDataModelImpl extends StaticDataModel {
  static StaticDataModelImpl? instance;

  StaticDataModelImpl._internal();

  factory StaticDataModelImpl() {
    instance ??= StaticDataModelImpl._internal();
    return instance!;
  }

  final StaticDataAgent _staticDataAgent = StaticDataAgentImpl();

  @override
  Future<List<String>?> getAllCategories() {
    return _staticDataAgent.getAllCategories().first;
  }

  @override
  Future<List<CoffeeVO>?> getAllCoffeeList() {
    return _staticDataAgent.getAllCoffeeList().first;
  }
}
