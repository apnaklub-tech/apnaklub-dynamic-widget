
import 'package:dynamic_widget/constants.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_widget.dart';

abstract class NewWidgetParser {

  /// convert a string to be logged in red color
  String toWarning(String s) {
    return '\x1B[31m$s\x1B[0m';
  }

  /// Assert type check of values of [map] at current level
  /// runs assertions on given [map].
  /// [attribute] is key of [map] on which assertion has to be performed
  /// [expectedType] is expected runtime type
  /// [allowNull] should allow null for this [attribute]
  void typeAssertionDriver(
      {required Map<String, dynamic> map,
        required String attribute,
        required String expectedType,
        bool allowNull = true}) {

    if(!allowNull && map[attribute] == null) {
      assert(false, toWarning("${widgetName}WidgetParser: For $attribute null is not allowed"));
      return;
    }

    String msg =
        "${widgetName}WidgetParser: Expecting $attribute as type of $expectedType but found ${map[attribute].runtimeType}";
    bool condition = true;


    switch (expectedType) {
      case TYPE_STRING:
        {
          condition = map[attribute] == null || map[attribute] is String;
          break;
        }
      case TYPE_MAP:
        {
          condition = allowNull
              ? map[attribute] == null || map[attribute] is Map
              : map[attribute] is Map;
          break;
        }
      case TYPE_INT:
        {
          condition = allowNull
              ? map[attribute] == null || map[attribute] is int
              : map[attribute] is Map;
          break;
        }
      case TYPE_DOUBLE:
        {
          condition = allowNull
              ? map[attribute] == null || map[attribute] is double
              : map[attribute] is Map;
          break;
        }
    }
    assert(condition, toWarning(msg));
  }


  /// called before parse method, do all assertions checks here. Call [typeAssertionDriver] function from this.
  void assertionChecks(Map<String, dynamic> map);


  /// parse the json map into a flutter widget.
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener);

  /// the widget type name for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method return "Text", for more details, please see
  /// @TextWidgetParser
  String get widgetName;

  /// export the runtime widget to json
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext);

  /// match current widget
  Type get widgetType;

  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;
}