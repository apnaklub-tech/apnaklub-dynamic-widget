import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';
import '../custom_widgets/if_else_widget.dart';

class ContainerWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map,
        attribute: 'ifWidget',
        expectedType: TYPE_MAP,
        allowNull: false);
    typeAssertionDriver(
        map: map,
        attribute: 'ifWidget',
        expectedType: TYPE_MAP,
        allowNull: false);
    typeAssertionDriver(
        map: map,
        attribute: 'condition',
        expectedType: TYPE_BOOL,
        allowNull: false);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    Map<String, dynamic>? ifMap = map['ifWidget'];
    Map<String, dynamic>? elseMap = map['elseWidget'];
    Widget? ifWidget =
        DynamicWidgetBuilder.buildFromMap(ifMap, buildContext, listener);
    Widget? elseWidget =
        DynamicWidgetBuilder.buildFromMap(elseMap, buildContext, listener);
    return IfElseWidget(
      ifWidget: ifWidget ?? const SizedBox.shrink(),
      elseWidget: elseWidget ?? const SizedBox.shrink(),
      condition: map['condition'],
    );
  }

  @override
  String get widgetName => 'IfElseWidget';

  @override
  Map<String, dynamic> export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as IfElseWidget;
    return <String, dynamic>{
      'type': widgetName,
      'ifWidget':
          DynamicWidgetBuilder.export(realWidget.ifWidget, buildContext),
      'elseWidget':
          DynamicWidgetBuilder.export(realWidget.elseWidget, buildContext),
      'condition': realWidget.condition,
    };
  }

  @override
  Type get widgetType => IfElseWidget;
}
