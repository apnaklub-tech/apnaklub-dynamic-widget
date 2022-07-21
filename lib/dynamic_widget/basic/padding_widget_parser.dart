import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class PaddingWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'padding', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return Padding(
      padding: map.containsKey("padding")
          ? parseEdgeInsetsGeometry(map["padding"])!
          : EdgeInsets.zero,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "Padding";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Padding;
    var padding = realWidget.padding as EdgeInsets;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "padding": padding != null
          ? "${padding.left},${padding.top},${padding.right},${padding.bottom}"
          : null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => Padding;
}
