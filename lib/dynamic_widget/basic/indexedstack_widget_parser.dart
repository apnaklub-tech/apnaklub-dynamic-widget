import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class IndexedStackWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'index', expectedType: TYPE_INT);
    typeAssertionDriver(map: map, attribute: 'alignment', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'textDirection', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'children', expectedType: TYPE_LIST);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    return IndexedStack(
      index: map.containsKey('index') ? map['index'] : 0,
      alignment: map.containsKey('alignment')
          ? parseAlignment(map['alignment'])!
          : AlignmentDirectional.topStart,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'IndexedStack';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as IndexedStack;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'index': realWidget.index,
      'alignment': realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : AlignmentDirectional.topStart,
      'textDirection': realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
      'children':
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext)
    };
  }

  @override
  Type get widgetType => IndexedStack;
}
