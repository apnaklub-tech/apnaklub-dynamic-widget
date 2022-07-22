import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class OpacityWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'opacity', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'alwaysIncludeSemantics', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    return Opacity(
      opacity: map['opacity']?.toDouble(),
      alwaysIncludeSemantics: map.containsKey('alwaysIncludeSemantics')
          ? map['alwaysIncludeSemantics']
          : false,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'Opacity';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as Opacity;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'opacity': realWidget.opacity,
      'alwaysIncludeSemantics': realWidget.alwaysIncludeSemantics,
      'child': DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Opacity;
}
