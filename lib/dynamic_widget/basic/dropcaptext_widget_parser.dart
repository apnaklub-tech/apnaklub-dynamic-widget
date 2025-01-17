import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/drop_cap_text.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/material.dart';

import '../../widget_parser.dart';

class DropCapTextParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }


  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    return DropCapText(
      data: map.containsKey('data') ? map['data'] : null,
      selectable: map.containsKey('selectable') ? map['selectable'] : false,
      mode: map.containsKey('mode')
          ? parseDropCapMode(map['mode'])
          : DropCapMode.inside,
      style: map.containsKey('style') ? parseTextStyle(map['style']) : null,
      dropCapStyle: map.containsKey('dropCapStyle')
          ? parseTextStyle(map['dropCapStyle'])
          : null,
      textAlign: map.containsKey('textAlign')
          ? parseTextAlign(map['textAlign'])
          : TextAlign.start,
      dropCap: map.containsKey('dropCap')
          ? parseDropCap(map['dropCap'], buildContext, listener)
          : null,
      dropCapPadding: map.containsKey('dropCapPadding')
          ? parseEdgeInsetsGeometry(map['dropCapPadding']) as EdgeInsets?
          : EdgeInsets.zero,
      indentation: Offset.zero,
      //todo: actually add this
      dropCapChars: map.containsKey('dropCapChars') ? map['dropCapChars'] : 1,
      forceNoDescent:
          map.containsKey('forceNoDescent') ? map['forceNoDescent'] : false,
      parseInlineMarkdown: map.containsKey('parseInlineMarkdown')
          ? map['parseInlineMarkdown']
          : false,
      textDirection: map.containsKey('textDirection')
          ? parseTextDirection(map['textDirection'])
          : TextDirection.ltr,
      overflow: map.containsKey('overflow')
          ? parseTextOverflow(map['overflow'])
          : TextOverflow.clip,
      maxLines: map.containsKey('maxLines') ? map['maxLines'] : null,
      dropCapPosition: map.containsKey('dropCapPosition')
          ? parseDropCapPosition(map['dropCapPosition'])
          : null,
    );
  }

  @override
  String get widgetName => 'DropCapText';

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as DropCapText;
    var dropCapPadding = realWidget.dropCapPadding;
    return <String, dynamic>{ 'id':id,
      'type': widgetName,
      'data': realWidget.data,
      'selectable': realWidget.selectable,
      'mode': exportDropCapMod(realWidget.mode),
      'style': exportTextStyle(realWidget.style),
      'dropCapStyle': exportTextStyle(realWidget.dropCapStyle),
      'textAlign': exportTextAlign(realWidget.textAlign),
      'dropCap': exportDropCap(realWidget.dropCap, buildContext, id),
      'dropCapPadding': dropCapPadding != null
          ? '${dropCapPadding.left},${dropCapPadding.top},${dropCapPadding.right},${dropCapPadding.bottom}'
          : null,
      'dropCapChars': realWidget.dropCapChars,
      'forceNoDescent': realWidget.forceNoDescent,
      'parseInlineMarkdown': realWidget.parseInlineMarkdown ?? false,
      'textDirection': exportTextDirection(realWidget.textDirection),
      'overflow': exportTextOverflow(realWidget.overflow),
      'maxLines': realWidget.maxLines,
      'dropCapPosition': realWidget.dropCapPosition != null
          ? exportDropCapPosition(realWidget.dropCapPosition)
          : null
    };
  }

  @override
  Type get widgetType => DropCapText;
}
