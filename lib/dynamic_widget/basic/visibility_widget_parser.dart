import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:flutter/widgets.dart';

import '../../assertions/assert_constants.dart';
import '../../utils/event_listener.dart';
import '../../widget_parser.dart';

class VisibilityWidgetParser extends WidgetParser {
  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    bool? visible = map['visible'];
    Map<String, dynamic>? childMap = map['child'];
    
    Widget? child = DynamicWidgetBuilder.buildFromMap(childMap, buildContext, listener);
    
    // Assert child as not null.

    return Visibility(
      visible: visible ?? true,
      child: child ?? const SizedBox(),
    );
  }

  @override
  String get widgetName => 'Visibility';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as Visibility;
    return <String, dynamic>{
      'id': id,
      'type': widgetName,
      'visible': realWidget.visible,
      'child': DynamicWidgetBuilder.export(realWidget.child, buildContext)
    };
  }

  @override
  Type get widgetType => Visibility;
  
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'child', expectedType: TYPE_MAP);
    typeAssertionDriver(map: map, attribute: 'visible', expectedType: TYPE_BOOL, allowNull: false);
  }
}
