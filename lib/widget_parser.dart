
import 'package:dynamic_widget/assertions/type_assertions.dart';
import 'package:dynamic_widget/dynamic_value_notifier.dart';
import 'package:flutter/widgets.dart';

import 'dynamic_widget.dart';

abstract class WidgetParser {

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
    typeAssertions = typeAssertions?? TypeAssertions(widgetName);
    typeAssertions!.run(map: map, attribute: attribute, expectedType: expectedType);
  }

  TypeAssertions? typeAssertions;
  DynamicValueNotifier valueNotifier = DynamicValueNotifier();

  /// called before parse method, do all assertions checks here. Call [typeAssertionDriver] function from this.
  void assertionChecks(Map<String, dynamic> map);


  /// parse the json map into a flutter widget.
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {

    assertionChecks(map);

    String? id = map["id"];

    if(id != null) {
      /// wrap widget inside [ValueListenableBuilder] only when their is ID
      /// because then only it is going to be accessible
      valueNotifier = DynamicValueNotifier(value: map);
      listener?.controller?[id] = valueNotifier;
      return ValueListenableBuilder(
          valueListenable: valueNotifier, builder: (context, value, child) {
        return build(map, buildContext, listener);
      });
    }
    return build(map, buildContext, listener);
  }

  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener);

  /// the widget type name for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method return "Text", for more details, please see
  /// @TextWidgetParser
  String get widgetName;

  /// export the runtime widget to json
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext, String id);

  /// match current widget
  Type get widgetType;

  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;
}