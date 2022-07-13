import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/boxdecoration_parser.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

const String expectedTypeString = "String";
const String expectedTypeMap = "Map";
const String expectedTypeInt = "Int";
const String expectedTypeDouble = "Double";

class ContainerWidgetParser extends NewWidgetParser {

  String toWarning(String s) {
    return '\x1B[31m$s\x1B[0m';
  }

  void checkAssertion(
      {required Map<String, dynamic> map,
      required String attribute,
      required String expectedType,
      bool allowNull = true}) {

    String msg =
        "${widgetName}WidgetParser: Expecting $attribute as type of $expectedType but found ${map[attribute].runtimeType}";
    bool condition = true;

    if(!allowNull && map[attribute] == null) {
      assert(false, toWarning("${widgetName}WidgetParser: For $attribute null is not allowed"));
      return;
    }

    switch (expectedType) {
      case expectedTypeString:
        {
          condition = map[attribute] == null || map[attribute] is String;
          break;
        }
      case expectedTypeMap:
        {
          condition = allowNull
              ? map[attribute] == null || map[attribute] is Map
              : map[attribute] is Map;
          break;
        }
      case expectedTypeInt:
        {
          condition = allowNull
              ? map[attribute] == null || map[attribute] is int
              : map[attribute] is Map;
          break;
        }
      case expectedTypeDouble:
        {
          condition = allowNull
              ? map[attribute] == null || map[attribute] is double
              : map[attribute] is Map;
          break;
        }
    }
    assert(condition, toWarning(msg));
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    checkAssertion(
        map: map, attribute: "alignment", expectedType: expectedTypeString);
    checkAssertion(
        map: map, attribute: "color", expectedType: expectedTypeString);
    checkAssertion(
        map: map, attribute: "constraints", expectedType: expectedTypeMap);
    checkAssertion(
        map: map, attribute: "margin", expectedType: expectedTypeString);
    checkAssertion(
        map: map, attribute: "padding", expectedType: expectedTypeString);
    checkAssertion(map: map, attribute: "child", expectedType: expectedTypeMap);
    checkAssertion(
        map: map, attribute: "decoration", expectedType: expectedTypeMap);
    checkAssertion(
        map: map, attribute: "width", expectedType: expectedTypeDouble);
    checkAssertion(
        map: map, attribute: "height", expectedType: expectedTypeDouble);

    Alignment? alignment = parseAlignment(map['alignment']);
    Color? color = parseHexColor(map['color']);
    BoxConstraints? constraints = parseBoxConstraints(map['constraints']);
    //TODO: foregroundDecoration and transform properties to be implemented.
    EdgeInsetsGeometry? margin = parseEdgeInsetsGeometry(map['margin']);
    EdgeInsetsGeometry? padding = parseEdgeInsetsGeometry(map['padding']);
    Map<String, dynamic>? childMap = map['child'];
    Widget? child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : null;

    var containerWidget = Container(
      alignment: alignment,
      padding: padding,
      // color: color,
      decoration: parseBoxDecoration(map['decoration']),
      margin: margin,
      width: map['width']?.toDouble(),
      height: map['height']?.toDouble(),
      constraints: constraints,
      child: child,
    );

    if (listener != null && clickEvent != null) {
      return GestureDetector(
        onTap: () {
          listener.clickListener!.onClicked(clickEvent);
        },
        child: containerWidget,
      );
    } else {
      return containerWidget;
    }
  }

  @override
  String get widgetName => "Container";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    var realWidget = widget as Container;
    var padding = realWidget.padding as EdgeInsets?;
    var margin = realWidget.margin as EdgeInsets?;
    var constraints = realWidget.constraints;
    return <String, dynamic>{
      "type": widgetName,
      "alignment": realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : null,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      //* color in decoration overrides the color causing problems
      // "color": realWidget.color != null
      //     ? realWidget.color!.value.toRadixString(16)
      //     : null,
      "decoration": exportBoxDecoration(realWidget.decoration != null
          ? realWidget.decoration as BoxDecoration
          : null),
      "margin": margin != null
          ? "${margin.left},${margin.top},${margin.right},${margin.bottom}"
          : null,
      "constraints":
          constraints != null ? exportConstraints(constraints) : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Container;
}
