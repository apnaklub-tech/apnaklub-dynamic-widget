import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class RotatedBoxWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map, attribute: 'quarterTurns', expectedType: TYPE_INT);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Map<String, dynamic>? export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as RotatedBox;
    return <String, dynamic>{
      'id': id.toString(),
      'type': widgetName,
      'quarterTurns': realWidget.quarterTurns,
      'child': DynamicWidgetBuilder.export(realWidget.child, buildContext),
    };
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    return RotatedBox(
      quarterTurns: map['quarterTurns'],
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'RotatedBox';

  @override
  Type get widgetType => RotatedBox;
}
