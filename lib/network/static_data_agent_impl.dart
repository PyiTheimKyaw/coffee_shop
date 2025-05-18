import 'package:coffee_shop/data/vos/coffee_vo.dart';
import 'package:coffee_shop/network/static_data_agent.dart';
import 'package:firebase_database/firebase_database.dart';

import '../utils/strings.dart';

class StaticDataAgentImpl extends StaticDataAgent {
  static StaticDataAgentImpl? instance;

  factory StaticDataAgentImpl() {
    instance ??= StaticDataAgentImpl._internal();
    return instance!;
  }

  StaticDataAgentImpl._internal();

  final databaseRef = FirebaseDatabase.instance.ref();

  @override
  Stream<List<String>?> getAllCategories() {
    return databaseRef.child(kFirebaseRefCoffeeCategories).onValue.map((event) {
      return (event.snapshot.value as List<dynamic>).map((element) => element.toString()).toList();
    });
  }

  @override
  Stream<List<CoffeeVO>> getAllCoffeeList() {
    return databaseRef.child(kFirebaseRefCoffeeList).onValue.map((event) {
      if (event.snapshot.value == null) return <CoffeeVO>[];
      return event.snapshot.children.map<CoffeeVO>((snapshot) {
        final rawData = snapshot.value;
        if (rawData is Map<Object?, Object?>) {
          final convertedData = _convertToMap(rawData);
          return CoffeeVO.fromJson(convertedData);
        } else {
          throw Exception("Unexpected data format from Firebase: $rawData");
        }
      }).toList();
    });
  }



  Map<String, dynamic> _convertToMap(Map<Object?, Object?> input) {
    return input.map((key, value) {
      if (value is Map<Object?, Object?>) {
        return MapEntry(key.toString(), _convertToMap(value)); // Recursively convert nested maps
      } else if (value is List) {
        return MapEntry(key.toString(), _convertToList(value)); // Convert lists properly
      } else {
        return MapEntry(key.toString(), value);
      }
    });
  }

// Helper function to process lists
  List<dynamic> _convertToList(List list) {
    return list.map((item) {
      if (item is Map<Object?, Object?>) {
        return _convertToMap(item);
      }
      return item;
    }).toList();
  }
}

