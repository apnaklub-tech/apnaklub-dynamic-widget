import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/boxdecoration_parser.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../new_widget_parser.dart';

class ContainerWidgetParser extends NewWidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map, attribute: "alignment", expectedType: TYPE_STRING);
    typeAssertionDriver(
        map: map, attribute: "color", expectedType: TYPE_STRING);
    typeAssertionDriver(
        map: map, attribute: "constraints", expectedType: TYPE_MAP);
    typeAssertionDriver(
        map: map, attribute: "margin", expectedType: TYPE_STRING);
    typeAssertionDriver(
        map: map, attribute: "padding", expectedType: TYPE_STRING);
    typeAssertionDriver(
        map: map, attribute: "child", expectedType: TYPE_STRINGED_MAP);
    typeAssertionDriver(
        map: map, attribute: "decoration", expectedType: TYPE_MAP);
    typeAssertionDriver(
        map: map, attribute: "width", expectedType: TYPE_DOUBLE);
    typeAssertionDriver(
        map: map, attribute: "height", expectedType: TYPE_DOUBLE);
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
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
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Container;
    var padding = realWidget.padding as EdgeInsets?;
    var margin = realWidget.margin as EdgeInsets?;
    var constraints = realWidget.constraints;
    return <String, dynamic>{ "id":id,
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
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => Container;
}
