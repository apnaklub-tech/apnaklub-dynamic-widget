import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../../new_widget_parser.dart';

class LimitedBoxWidgetParser extends NewWidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext) {
    LimitedBox realWidget = widget as LimitedBox;
    return <String, dynamic>{
      "type": widgetName,
      "maxWidth": realWidget.maxWidth == double.infinity
          ? infinity
          : realWidget.maxWidth,
      "maxHeight": realWidget.maxHeight == double.infinity
          ? infinity
          : realWidget.maxHeight,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return LimitedBox(
      maxWidth: map.containsKey("maxWidth") ? map['maxWidth'] : double.infinity,
      maxHeight:
          map.containsKey("maxHeight") ? map['maxHeight'] : double.infinity,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => "LimitedBox";

  @override
  Type get widgetType => LimitedBox;
}
