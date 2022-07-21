import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class OpacityWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return Opacity(
      opacity: map["opacity"]?.toDouble(),
      alwaysIncludeSemantics: map.containsKey("alwaysIncludeSemantics")
          ? map["alwaysIncludeSemantics"]
          : false,
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "Opacity";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Opacity;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "opacity": realWidget.opacity,
      "alwaysIncludeSemantics": realWidget.alwaysIncludeSemantics,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => Opacity;
}
