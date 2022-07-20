import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../new_widget_parser.dart';

class OverflowBoxWidgetParser extends NewWidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    OverflowBox realWidget = widget as OverflowBox;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "minWidth": realWidget.minWidth,
      "maxWidth": realWidget.maxWidth,
      "minHeight": realWidget.minHeight,
      "maxHeight": realWidget.maxHeight,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return OverflowBox(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])!
          : Alignment.center,
      minWidth: map.containsKey("minWidth") ? map['minWidth'] : null,
      maxWidth: map.containsKey("maxWidth") ? map['maxWidth'] : null,
      minHeight: map.containsKey("minHeight") ? map['minHeight'] : null,
      maxHeight: map.containsKey("maxHeight") ? map['maxHeight'] : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map['child'], buildContext, listener),
    );
  }

  @override
  String get widgetName => "OverflowBox";

  @override
  Type get widgetType => OverflowBox;
}
