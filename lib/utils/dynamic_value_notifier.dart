
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

class DynamicValueNotifier extends ValueNotifier<Map<String, dynamic>>{
  DynamicValueNotifier({Map<String, dynamic> value = const {}}) : super(value);

  bool updateValue(String key, dynamic value) {
    try{
      this.value[key] = value;
      notifyListeners();
      return true;
    } catch(e) {
      print(toWarning("ERROR: updateValue $e"));
      return false;
    }
  }
}