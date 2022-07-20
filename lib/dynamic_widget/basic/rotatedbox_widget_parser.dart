import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../../new_widget_parser.dart';

class RotatedBoxWidgetParser extends NewWidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }


  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as RotatedBox;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "quarterTurns": realWidget.quarterTurns,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id),
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return RotatedBox(
      quarterTurns: map['quarterTurns'],
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "RotatedBox";

  @override
  Type get widgetType => RotatedBox;
}
