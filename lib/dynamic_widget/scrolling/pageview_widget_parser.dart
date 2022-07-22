import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class PageViewWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'scrollDirection', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'reverse', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'pageSnapping', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'children', expectedType: TYPE_LIST);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey('scrollDirection') &&
        'horizontal' == map['scrollDirection']) {
      scrollDirection = Axis.horizontal;
    }
    return PageView(
      scrollDirection: scrollDirection,
      reverse: map.containsKey('reverse') ? map['reverse'] : false,
      pageSnapping:
          map.containsKey('pageSnapping') ? map['pageSnapping'] : true,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }

  @override
  String get widgetName => 'PageView';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as PageView;
    String scrollDirection = 'vertical';
    if (realWidget.scrollDirection == Axis.horizontal) {
      scrollDirection = 'horizontal';
    }
    var children = realWidget.childrenDelegate as SliverChildListDelegate;
    return <String, dynamic>{ 'id':id,
      'type': 'PageView',
      'scrollDirection': scrollDirection,
      'reverse': realWidget.reverse,
      'pageSnapping': realWidget.pageSnapping,
      'children':
          DynamicWidgetBuilder.exportWidgets(children.children, buildContext)
    };
  }

  @override
  Type get widgetType => PageView;
}
