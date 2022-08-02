import 'package:dynamic_widget/utils/utils.dart';
import 'package:flutter/material.dart';

class DynamicValueNotifier extends ValueNotifier<Map<String, dynamic>> {
  DynamicValueNotifier({Map<String, dynamic> value = const {}}) : super(value);

  bool updateValue(String key, dynamic value) {
    try {
      this.value[key] = value;
      notifyListeners();
      return true;
    } catch (e) {
      print(toWarning('ERROR: updateValue $e'));
      return false;
    }
  }

  bool updateMultiple(Map<String, dynamic> map) {
    try {
      map.forEach((key, value) {
        if (this.value.containsKey(key)) {
          this.value[key] = value;
        }
      });
      notifyListeners();
      return true;
    } catch (e) {
      print(toWarning('ERROR: updateMultiple $e'));
      return false;
    }
  }

  bool updateAndAddMultiple(Map<String, dynamic> map) {
    try {
      map.forEach((key, value) {
        this.value[key] = value;
      });
      notifyListeners();
      return true;
    } catch (e) {
      print(toWarning('ERROR: updateMultiple $e'));
      return false;
    }
  }

  bool remove(String key) {
    try {
      value.remove(key);
      notifyListeners();
      return true;
    } catch (e) {
      print(toWarning('ERROR: updateValue $e'));
      return false;
    }
  }

  bool removeMultiple(List<String> keys) {
    try {
      for (var key in keys) {
        value.remove(key);
      }
      notifyListeners();
      return true;
    } catch (e) {
      print(toWarning('ERROR: updateValue $e'));
      return false;
    }
  }
}
