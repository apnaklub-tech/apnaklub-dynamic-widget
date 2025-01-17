import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/icons_helper.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../../widget_parser.dart';

class IconWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'data', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'size', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'color', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'semanticLabel', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'textDirection', expectedType: TYPE_STRING);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    return Icon(
      map.containsKey('data')
          ? getIconUsingPrefix(name: map['data'])
          : Icons.android,
      size: map.containsKey('size') ? map['size']?.toDouble() : null,
      color: map.containsKey('color') ? parseHexColor(map['color']) : null,
      semanticLabel:
          map.containsKey('semanticLabel') ? map['semanticLabel'] : null,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
    );
  }

  @override
  String get widgetName => 'Icon';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as Icon;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'data': exportIconGuessFavorMaterial(realWidget.icon),
      'size': realWidget.size,
      'color': realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      'semanticLabel': realWidget.semanticLabel,
      'textDirection': realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
    };
  }

  @override
  Type get widgetType => Icon;
}
