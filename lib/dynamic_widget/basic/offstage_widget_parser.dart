import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/cupertino.dart';

import '../../widget_parser.dart';

class OffstageWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'offstage', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    Offstage realWidget = widget as Offstage;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'offstage': realWidget.offstage,
      'child': DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    return Offstage(
      offstage: map.containsKey('offstage') ? map['offstage'] : true,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'Offstage';

  @override
  Type get widgetType => Offstage;
}
