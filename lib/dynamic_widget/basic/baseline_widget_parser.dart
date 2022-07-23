import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class BaselineWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map, attribute: 'baseline', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(
        map: map, attribute: 'baselineType', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    return Baseline(
      baseline: map['baseline']?.toDouble(),
      baselineType: map['baselineType'] == 'alphabetic'
          ? TextBaseline.alphabetic
          : TextBaseline.ideographic,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'Baseline';

  @override
  Map<String, dynamic> export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as Baseline;
    return <String, dynamic>{
      'id': id.toString(),
      'type': widgetName,
      'baseline': realWidget.baseline,
      'baselineType': realWidget.baselineType == TextBaseline.alphabetic
          ? 'alphabetic'
          : 'ideographic',
      'child': DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Baseline;
}
