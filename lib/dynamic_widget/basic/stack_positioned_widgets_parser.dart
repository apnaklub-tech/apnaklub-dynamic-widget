import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../new_widget_parser.dart';

class PositionedWidgetParser extends NewWidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return Positioned(
      child: DynamicWidgetBuilder.buildFromMap(
          map["child"], buildContext, listener)!,
      top: map.containsKey("top") ? map["top"]?.toDouble() : null,
      right: map.containsKey("right") ? map["right"]?.toDouble() : null,
      bottom: map.containsKey("bottom") ? map["bottom"]?.toDouble() : null,
      left: map.containsKey("left") ? map["left"]?.toDouble() : null,
      width: map.containsKey("width") ? map["width"]?.toDouble() : null,
      height: map.containsKey("height") ? map["height"]?.toDouble() : null,
    );
  }

  @override
  String get widgetName => "Positioned";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Positioned;
    return <String, dynamic>{ "id":id,
      "type": "Positioned",
      "top": realWidget.top ?? null,
      "right": realWidget.right ?? null,
      "bottom": realWidget.bottom ?? null,
      "left": realWidget.left ?? null,
      "width": realWidget.width ?? null,
      "height": realWidget.height ?? null,
      "child": DynamicWidgetBuilder.export(realWidget.child, buildContext, id)
    };
  }

  @override
  Type get widgetType => Positioned;
}

class StackWidgetParser extends NewWidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    // TODO: implement assertionChecks
  }

  @override
  Widget parse(Map<String, dynamic> map, BuildContext buildContext,
      EventListener? listener) {
    return Stack(
      alignment: map.containsKey("alignment")
          ? parseAlignment(map["alignment"])!
          : AlignmentDirectional.topStart,
      textDirection: map.containsKey("textDirection")
          ? parseTextDirection(map["textDirection"])
          : null,
      fit: map.containsKey("fit") ? parseStackFit(map["fit"])! : StackFit.loose,
      clipBehavior: map.containsKey("clipBehavior")
          ? parseClip(map["clipBehavior"])!
          : Clip.hardEdge,
      children: DynamicWidgetBuilder.buildWidgets(
          map['children'], buildContext, listener),
    );
  }

  @override
  String get widgetName => "Stack";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, String id) {
    var realWidget = widget as Stack;
    return <String, dynamic>{ "id":id,
      "type": "Stack",
      "alignment": realWidget.alignment is AlignmentDirectional
          ? exportAlignmentDirectional(
              realWidget.alignment as AlignmentDirectional)
          : exportAlignment(realWidget.alignment as Alignment),
      "textDirection": exportTextDirection(realWidget.textDirection),
      "fit": exportStackFit(realWidget.fit),
      "clipBehavior": exportClipBehavior(realWidget.clipBehavior),
      "children":
          DynamicWidgetBuilder.exportWidgets(realWidget.children, buildContext, id)
    };
  }

  @override
  Type get widgetType => Stack;
}
