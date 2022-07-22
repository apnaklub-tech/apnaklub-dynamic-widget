import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class FlexWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'direction', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'crossAxisAlignment', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'mainAxisAlignment', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'mainAxisSize', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'textBaseline', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'textDirection', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'verticalDirection', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'children', expectedType: TYPE_LIST);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    return Flex(
      direction: map.containsKey('direction')
          ? parseAxis(map['direction'])
          : Axis.horizontal,
      crossAxisAlignment: map.containsKey('crossAxisAlignment')
          ? parseCrossAxisAlignment(map['crossAxisAlignment'])
          : CrossAxisAlignment.center,
      mainAxisAlignment: map.containsKey('mainAxisAlignment')
          ? parseMainAxisAlignment(map['mainAxisAlignment'])
          : MainAxisAlignment.start,
      mainAxisSize: map.containsKey('mainAxisSize')
          ? parseMainAxisSize(map['mainAxisSize'])
          : MainAxisSize.max,
      textBaseline: map.containsKey('textBaseline')
          ? parseTextBaseline(map['textBaseline'])
          : null,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : null,
      verticalDirection: map.containsKey('verticalDirection')
          ? parseVerticalDirection(map['verticalDirection'])
          : VerticalDirection.down,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'Flex';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext buildContext, int id) {
    var realWidget = widget as Flex;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'direction':
          realWidget.direction == Axis.horizontal ? 'horizontal' : 'vertical',
      'crossAxisAlignment':
          exportCrossAxisAlignment(realWidget.crossAxisAlignment),
      'mainAxisAlignment':
          exportMainAxisAlignment(realWidget.mainAxisAlignment),
      'mainAxisSize':
          realWidget.mainAxisSize == MainAxisSize.max ? 'max' : 'min',
      'textBaseline': realWidget.textBaseline == TextBaseline.alphabetic
          ? 'alphabetic'
          : 'ideographic',
      'textDirection': realWidget.textDirection != null
          ? exportTextDirection(realWidget.textDirection)
          : null,
      'verticalDirection':
          realWidget.verticalDirection == VerticalDirection.down
              ? 'down'
              : 'up',
      'children':
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext),
    };
  }

  @override
  Type get widgetType => Flex;
}
