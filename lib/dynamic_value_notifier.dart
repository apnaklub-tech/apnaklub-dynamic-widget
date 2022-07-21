
import 'package:flutter/material.dart';

class DynamicValueNotifier extends ValueNotifier<Map<String, dynamic>>{
  DynamicValueNotifier({Map<String, dynamic> value = const {}}) : super(value);

  bool updateValue(String key, dynamic value) {
    try{
      value[key] = value;
      notifyListeners();
      return true;
    } catch(e) {
      return false;
    }
  }
}