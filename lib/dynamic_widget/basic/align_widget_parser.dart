import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/utils.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../assertions/assert_constants.dart';
import '../../widget_parser.dart';

class AlignWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map, attribute: 'alignment', expectedType: TYPE_STRING);
    typeAssertionDriver(
        map: map, attribute: 'widthFactor', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(
        map: map, attribute: 'heightFactor', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    return Align(
      alignment: map.containsKey('alignment')
          ? parseAlignment(map['alignment'])!
          : Alignment.center,
      widthFactor: map.containsKey('widthFactor')
          ? map['widthFactor']?.toDouble()
          : null,
      heightFactor: map.containsKey('heightFactor')
          ? map['heightFactor']?.toDouble()
          : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'Align';

  @override
  Map<String, dynamic> export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as Align;
    Map<String, dynamic> json = {
      'id': id.toString(),
      'type': widgetName,
      'alignment': exportAlignment(realWidget.alignment as Alignment?),
      'widthFactor': realWidget.widthFactor,
      'heightFactor': realWidget.heightFactor,
      'child': DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
    return json;
  }

  @override
  Type get widgetType => Align;
}
