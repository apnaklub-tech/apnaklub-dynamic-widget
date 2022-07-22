import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/material.dart';

import '../../dynamic_widget.dart';
import '../../widget_parser.dart';
import '../utils.dart';

class ListTileWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'isThreeLine', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'leading', expectedType: TYPE_MAP);
    typeAssertionDriver(map: map, attribute: 'title', expectedType: TYPE_MAP);
    typeAssertionDriver(map: map, attribute: 'subtitle', expectedType: TYPE_MAP);
    typeAssertionDriver(map: map, attribute: 'trailing', expectedType: TYPE_MAP);
    typeAssertionDriver(map: map, attribute: 'dense', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'contentPadding', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'enabled', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'selected', expectedType: TYPE_BOOL);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    bool isThreeLine =
        map.containsKey('isThreeLine') ? map['isThreeLine'] : false;
    EdgeInsetsGeometry? contentPadding = map.containsKey('contentPadding')
        ? parseEdgeInsetsGeometry(map['contentPadding'])
        : null;
    bool? dense = map.containsKey('dense') ? map['dense'] : false;
    bool enabled = map.containsKey('enabled') ? map['enabled'] : true;
    Widget? leading = map.containsKey('leading')
        ? DynamicWidgetBuilder.buildFromMap(
            map['leading'], buildContext, listener)
        : null;
    bool selected = map.containsKey('selected') ? map['selected'] : false;
    Widget? subtitle = map.containsKey('subtitle')
        ? DynamicWidgetBuilder.buildFromMap(
            map['subtitle'], buildContext, listener)
        : null;
    Widget? title = map.containsKey('title')
        ? DynamicWidgetBuilder.buildFromMap(
            map['title'], buildContext, listener)
        : null;
    Widget? trailing = map.containsKey('trailing')
        ? DynamicWidgetBuilder.buildFromMap(
            map['trailing'], buildContext, listener)
        : null;
    int clickEvent =map['id'];
    return ListTile(
      isThreeLine: isThreeLine,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: () {
        listener.clickListener!.onClicked(clickEvent);
      },
      selected: selected,
    );
  }

  @override
  String get widgetName => 'ListTile';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as ListTile;
    var contentPadding = realWidget.contentPadding as EdgeInsets?;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'isThreeLine': realWidget.isThreeLine,
      'leading': realWidget.leading != null
          ? DynamicWidgetBuilder.export(realWidget.leading, buildContext)
          : null,
      'title': realWidget.title != null
          ? DynamicWidgetBuilder.export(realWidget.title, buildContext)
          : null,
      'subtitle': realWidget.subtitle != null
          ? DynamicWidgetBuilder.export(realWidget.subtitle, buildContext)
          : null,
      'trailing': realWidget.trailing != null
          ? DynamicWidgetBuilder.export(realWidget.trailing, buildContext)
          : null,
      'dense': realWidget.dense,
      'contentPadding': contentPadding != null
          ? '${contentPadding.left},${contentPadding.top},${contentPadding.right},${contentPadding.bottom}'
          : null,
      'enabled': realWidget.enabled,
      'selected': realWidget.selected
    };
  }

  @override
  Type get widgetType => ListTile;
}
