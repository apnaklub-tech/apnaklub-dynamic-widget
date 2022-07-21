import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../../widget_parser.dart';

class InkwellWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";
    try {
      var inkwell = InkWell(
        splashColor: map.containsKey('splashColor')
            ? parseHexColor(map['splashColor'])
            : null,
        child: DynamicWidgetBuilder.buildFromMap(
            map['child'], buildContext, listener),
        onTap: () {
          listener!.clickListener!.onClicked(clickEvent);
        },
      );

      return inkwell;
    } catch (e) {
      print('--' * 100);
      print(map);
      print(e.toString());
      print('--' * 100);
      throw e;
    }
  }

  @override
  String get widgetName => "Inkwell";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as InkWell;

    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => InkWell;
}
