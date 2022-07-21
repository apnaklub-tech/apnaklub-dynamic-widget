import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../../widget_parser.dart';

class SingleChildScrollViewParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'scrollDirection', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'reverse', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'padding', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'clipBehavior', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as SingleChildScrollView;
    String scrollDirection = "vertical";
    if (realWidget.scrollDirection == Axis.horizontal) {
      scrollDirection = "horizontal";
    }

    var padding = realWidget.padding as EdgeInsets?;

    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "scrollDirection": scrollDirection,
      "reverse": realWidget.reverse,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "clipBehavior":exportClip(realWidget.clipBehavior),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }

    var clipBehaviorString = map['clipBehavior'];

    try{
      child = getChild(child, map, buildContext, listener);
      return SingleChildScrollView(
      reverse: map.containsKey('reverse') ? map['reverse'] : false,
      clipBehavior: parseClipBehavior(clipBehaviorString),
      padding: map.containsKey("padding")
          ? parseEdgeInsetsGeometry(map["padding"])
          : EdgeInsets.zero,
      scrollDirection: scrollDirection,
      child: child
    );}catch(e){
      print('--' * 100);
      print(map);
      print(e.toString());
      print('--' * 100);
      throw e;
    }
  }

  Widget? getChild(Widget? child, Map<String, dynamic> map, BuildContext buildContext, EventListener listener) {
    child = DynamicWidgetBuilder.buildFromMap(
      map['child'],
      buildContext,
      listener,
    );
    return child;
  }

  @override
  String get widgetName => "SingleChildScrollView";

  @override
  Type get widgetType => SingleChildScrollView;
}
