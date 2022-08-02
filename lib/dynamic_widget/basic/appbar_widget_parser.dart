import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/utils.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/material.dart';

import '../../widget_parser.dart';

class AppBarWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'title', expectedType: TYPE_MAP);
    typeAssertionDriver(map: map, attribute: 'leading', expectedType: TYPE_MAP);
    typeAssertionDriver(
        map: map, attribute: 'actions', expectedType: TYPE_LIST);
    typeAssertionDriver(
        map: map, attribute: 'centerTitle', expectedType: TYPE_BOOL);
    typeAssertionDriver(
        map: map, attribute: 'backgroundColor', expectedType: TYPE_STRING);
  }

  @override
  Map<String, dynamic> export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as AppBar;
    return <String, dynamic>{
      'id': id.toString(),
      'type': widgetName,
      'title': realWidget.title == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.title, buildContext),
      'leading': realWidget.leading == null
          ? null
          : DynamicWidgetBuilder.export(realWidget.leading, buildContext),
      'actions': realWidget.actions == null
          ? null
          : DynamicWidgetBuilder.exportWidgets(
              realWidget.actions!, buildContext),
      'centerTitle': realWidget.centerTitle,
      'backgroundColor': realWidget.backgroundColor == null
          ? null
          : realWidget.backgroundColor!.value.toRadixString(16),
    };
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    var appBarWidget = AppBar(
      title: map.containsKey('title')
          ? DynamicWidgetBuilder.buildFromMap(
              map['title'], buildContext, listener)
          : null,
      leading: map.containsKey('leading')
          ? DynamicWidgetBuilder.buildFromMap(
              map['leading'], buildContext, listener)
          : null,
      actions: map.containsKey('actions')
          ? DynamicWidgetBuilder.buildWidgets(
              map['actions'], buildContext, listener)
          : null,
      centerTitle:
          map.containsKey('centerTitle') ? map['centerTitle'] as bool? : false,
      backgroundColor: map.containsKey('backgroundColor')
          ? parseHexColor(map['backgroundColor'])
          : null,
    );

    return appBarWidget;
  }

  @override
  String get widgetName => 'AppBar';

  @override
  Type get widgetType => AppBar;
}
