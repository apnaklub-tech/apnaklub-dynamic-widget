import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class AspectRatioWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return AspectRatio(
      aspectRatio: map["aspectRatio"]?.toDouble(),
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener),
    );
  }

  @override
  String get widgetName => "AspectRatio";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as AspectRatio;
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "aspectRatio": realWidget.aspectRatio,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => AspectRatio;
}
