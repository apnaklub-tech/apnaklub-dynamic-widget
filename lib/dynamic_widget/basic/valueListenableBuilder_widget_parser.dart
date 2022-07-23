import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class ValueListenableBuilderIntWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map, attribute: 'height', expectedType: TYPE_DOUBLE);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    Map<String, dynamic>? childMap = map['child'];
    if (childMap == null) {
      return const SizedBox.shrink();
    } else {
      return ValueListenableBuilder(
        builder: (BuildContext context, value, Widget? child) {
          return DynamicWidgetBuilder.buildFromMap(
                  childMap, buildContext, listener) ??
              const SizedBox.shrink();
        },
        valueListenable: ValueNotifier(0),
      );
    }
  }

  @override
  String get widgetName => 'ValueListenableBuilder';

  @override
  Map<String, dynamic> export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as ValueListenableBuilder;
    return <String, dynamic>{
      'id': id.toString(),
      'type': widgetName,
      'builder': DynamicWidgetBuilder.export(
          realWidget.builder(buildContext, 1, null), buildContext),
      'valueListenable': 'add-valueListenable-here'
    };
  }

  @override
  Type get widgetType => ValueListenableBuilder(
        builder: (context, value, child) {
          return Container();
        },
        valueListenable: ValueNotifier(1),
      ).runtimeType;
}

class ValueListenableBuilderStringWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(
        map: map, attribute: 'height', expectedType: TYPE_DOUBLE);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener,
      {Widget? child}) {
    Map<String, dynamic>? childMap = map['child'];
    if (childMap == null) {
      return const SizedBox.shrink();
    } else {
      return ValueListenableBuilder(
        builder: (BuildContext context, value, Widget? child) {
          return DynamicWidgetBuilder.buildFromMap(
                  childMap, buildContext, listener) ??
              const SizedBox.shrink();
        },
        valueListenable: ValueNotifier(0),
      );
    }
  }

  @override
  String get widgetName => 'ValueListenableBuilder';

  @override
  Map<String, dynamic> export(
      Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as ValueListenableBuilder;
    return <String, dynamic>{
      'id': id.toString(),
      'type': widgetName,
      'builder': DynamicWidgetBuilder.export(
          realWidget.builder(buildContext, 1, null), buildContext),
      'valueListenable': 'add-valueListenable-here'
    };
  }

  @override
  Type get widgetType => ValueListenableBuilder(
        builder: (context, value, child) {
          return Container();
        },
        valueListenable: ValueNotifier('s'),
      ).runtimeType;
}
// ValueListenableBuilder != ValueListenableBuilder<int>