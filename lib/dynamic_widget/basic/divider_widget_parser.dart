import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget_parser.dart';
import '../utils.dart';

class DividerWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext, String id) {
    Divider realWidget = widget as Divider;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "height": realWidget.height,
      "thickness": realWidget.thickness,
      "indent": realWidget.indent,
      "endIndent": realWidget.endIndent,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
    };
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return Divider(
      height: map["height"],
      thickness: map["thickness"],
      indent: map["indent"],
      endIndent: map["endIndent"],
      color: parseHexColor(map['color']),
    );
  }

  @override
  String get widgetName => "Divider";

  @override
  Type get widgetType => Divider;
}
