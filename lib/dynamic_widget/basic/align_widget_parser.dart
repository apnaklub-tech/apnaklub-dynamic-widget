import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../new_widget_parser.dart';

class AlignWidgetParser extends NewWidgetParser {
  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return Align(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])!
          : Alignment.center,
      widthFactor: map.containsKey("widthFactor")
          ? map["widthFactor"]?.toDouble()
          : null,
      heightFactor: map.containsKey("heightFactor")
          ? map["heightFactor"]?.toDouble()
          : null,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "Align";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Align;
    Map<String, dynamic> json = {
      "id": id,
      "type": widgetName,
      "alignment": exportAlignment(realWidget.alignment as Alignment?),
      "widthFactor": realWidget.widthFactor,
      "heightFactor": realWidget.heightFactor,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
    return json;
  }

  @override
  Type get widgetType => Align;

  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }
}
