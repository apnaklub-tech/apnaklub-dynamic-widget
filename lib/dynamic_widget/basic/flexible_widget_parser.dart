import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class FlexibleWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'fit', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'flex', expectedType: TYPE_INT);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    Map<String, dynamic>? childMap = map['child'];
    Widget? child = childMap == null
        ? null
        : DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);

    var flexibleWidget = Flexible(
      child: child ?? SizedBox.shrink(),
      fit: parseFlexFit(map['fit']),
      flex: map['flex'] != null? map['flex']:1,
    );

    return flexibleWidget;
  }

  @override
  String get widgetName => "Flexible";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Flexible;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "flex": realWidget.flex,
      "fit": exportFlexFit(realWidget.fit),
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => Flexible;
}
