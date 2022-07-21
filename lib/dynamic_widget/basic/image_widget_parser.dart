import 'dart:ui';

import 'package:dynamic_widget/assertions/assert_constants.dart';
import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:dynamic_widget/dynamic_widget/utils.dart';
import 'package:flutter/widgets.dart';

import '../../widget_parser.dart';

class AssetImageWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'name', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'semanticLabel', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'excludeFromSemantics', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'scale', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'width', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'height', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'color', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'colorBlendMode', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'fit', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'alignment', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'repeat', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'centerSlice', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'matchTextDirection', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'gaplessPlayback', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'filterQuality', expectedType: TYPE_STRING);
  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    String name = map['name'];
    String? semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics = map.containsKey('excludeFromSemantics')
        ? map['excludeFromSemantics']
        : false;
    double? scale = map.containsKey("scale") ? map['scale']?.toDouble() : null;
    double? width = map.containsKey('width') ? map['width']?.toDouble() : null;
    double? height =
        map.containsKey('height') ? map['height']?.toDouble() : null;
    Color? color =
        map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode? colorBlendMode = map.containsKey('colorBlendMode')
        ? parseBlendMode(map['colorBlendMode'])
        : null;
    BoxFit? fit = map.containsKey('fit') ? parseBoxFit(map['fit']) : null;
    Alignment alignment = map.containsKey('alignment')
        ? parseAlignment(map['alignment'])!
        : Alignment.center;
    ImageRepeat repeat = map.containsKey('repeat')
        ? parseImageRepeat(map['repeat'])!
        : ImageRepeat.noRepeat;
    Rect? centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection = map.containsKey('matchTextDirection')
        ? map['matchTextDirection']
        : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality = map.containsKey('filterQuality')
        ? parseFilterQuality(map['filterQuality'])!
        : FilterQuality.low;

    int clickEvent =map['id'];

    var widget = Image.asset(
      name,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null)) {
      return GestureDetector(
        onTap: () {
          listener.clickListener!.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  String get widgetName => "AssetImage";

  @override
  Map<String, dynamic>? export(Widget? widget, BuildContext? buildContext, int id) {
    if (_isMatchAssetImageType(widget)) {
      var realWidget = widget as Image;
      late AssetImage assetImage;
      if (realWidget.image is AssetImage) {
        assetImage = realWidget.image as AssetImage;
      } else if (realWidget.image is ResizeImage) {
        var t = realWidget.image as ResizeImage;
        assetImage = t.imageProvider as AssetImage;
      }
      return <String, dynamic>{ "id":id,
        "type": widgetName,
        "name": assetImage.assetName,
        "semanticLabel": realWidget.semanticLabel,
        "excludeFromSemantics": realWidget.excludeFromSemantics,
        "width": realWidget.width,
        "height": realWidget.height,
        "color": realWidget.color != null
            ? realWidget.color!.value.toRadixString(16)
            : null,
        "colorBlendMode": realWidget.colorBlendMode != null
            ? exportBlendMode(realWidget.colorBlendMode)
            : null,
        "fit": realWidget.fit != null ? exportBoxFit(realWidget.fit) : null,
        "alignment": realWidget.alignment != null
            ? exportAlignment(realWidget.alignment as Alignment?)
            : null,
        "repeat": realWidget.repeat != null
            ? exportImageRepeat(realWidget.repeat)
            : null,
        "centerSlice": realWidget.centerSlice != null
            ? exportRect(realWidget.centerSlice!)
            : null,
        "matchTextDirection": realWidget.matchTextDirection,
        "gaplessPlayback": realWidget.gaplessPlayback,
        "filterQuality": realWidget.filterQuality != null
            ? exportFilterQuality(realWidget.filterQuality)
            : null
      };
    }

    if (_isMatchExactAssetImageType(widget)) {
      var realWidget = widget as Image;
      late ExactAssetImage exactAssetImage;
      if (realWidget.image is ExactAssetImage) {
        exactAssetImage = realWidget.image as ExactAssetImage;
      } else if (realWidget.image is ResizeImage) {
        var t = realWidget.image as ResizeImage;
        exactAssetImage = t.imageProvider as ExactAssetImage;
      }
      return <String, dynamic>{ "id":id,
      "type": widgetName,
        "name": exactAssetImage.assetName,
        "semanticLabel": realWidget.semanticLabel,
        "excludeFromSemantics": realWidget.excludeFromSemantics,
        "scale": exactAssetImage.scale,
        "width": realWidget.width,
        "height": realWidget.height,
        "color": realWidget.color != null
            ? realWidget.color!.value.toRadixString(16)
            : null,
        "colorBlendMode": realWidget.colorBlendMode != null
            ? exportBlendMode(realWidget.colorBlendMode)
            : null,
        "fit": realWidget.fit != null ? exportBoxFit(realWidget.fit) : null,
        "alignment": realWidget.alignment != null
            ? exportAlignment(realWidget.alignment as Alignment?)
            : null,
        "repeat": realWidget.repeat != null
            ? exportImageRepeat(realWidget.repeat)
            : null,
        "centerSlice": realWidget.centerSlice != null
            ? exportRect(realWidget.centerSlice!)
            : null,
        "matchTextDirection": realWidget.matchTextDirection,
        "gaplessPlayback": realWidget.gaplessPlayback,
        "filterQuality": realWidget.filterQuality != null
            ? exportFilterQuality(realWidget.filterQuality)
            : null
      };
    }

    return null;
  }

  @override
  Type get widgetType => AssetImage;

  bool _isMatchAssetImageType(Widget? widget) {
    if (widget is Image) {
      if (widget.image is AssetImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var resizeImage = widget.image as ResizeImage;
        return resizeImage.imageProvider is AssetImage;
      }
    }
    return false;
  }

  bool _isMatchExactAssetImageType(Widget? widget) {
    if (widget is Image) {
      if (widget.image is ExactAssetImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var resizeImage = widget.image as ResizeImage;
        return resizeImage.imageProvider is ExactAssetImage;
      }
    }
    return false;
  }

  @override
  bool matchWidgetForExport(Widget? widget) =>
      _isMatchAssetImageType(widget) || _isMatchExactAssetImageType(widget);
}

class NetworkImageWidgetParser extends WidgetParser {
  @override
  void assertionChecks(Map<String, dynamic> map) {
    typeAssertionDriver(map: map, attribute: 'src', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'semanticLabel', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'excludeFromSemantics', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'scale', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'width', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'height', expectedType: TYPE_DOUBLE);
    typeAssertionDriver(map: map, attribute: 'color', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'colorBlendMode', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'fit', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'alignment', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'repeat', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'centerSlice', expectedType: TYPE_STRING);
    typeAssertionDriver(map: map, attribute: 'matchTextDirection', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'gaplessPlayback', expectedType: TYPE_BOOL);
    typeAssertionDriver(map: map, attribute: 'filterQuality', expectedType: TYPE_STRING);

  }

  @override
  Widget build(Map<String, dynamic> map, BuildContext buildContext,
      EventListener listener, {Widget? child}) {
    String src = map['src'];
    String? semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics = map.containsKey('excludeFromSemantics')
        ? map['excludeFromSemantics']
        : false;
    double scale = map.containsKey("scale") ? map['scale']?.toDouble() : 1.0;
    double? width = map.containsKey('width') ? map['width']?.toDouble() : null;
    double? height =
        map.containsKey('height') ? map['height']?.toDouble() : null;
    Color? color =
        map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode? colorBlendMode = map.containsKey('colorBlendMode')
        ? parseBlendMode(map['colorBlendMode'])
        : null;
    BoxFit? fit = map.containsKey('fit') ? parseBoxFit(map['fit']) : null;
    Alignment alignment = map.containsKey('alignment')
        ? parseAlignment(map['alignment'])!
        : Alignment.center;
    ImageRepeat repeat = map.containsKey('repeat')
        ? parseImageRepeat(map['repeat'])!
        : ImageRepeat.noRepeat;
    Rect? centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection = map.containsKey('matchTextDirection')
        ? map['matchTextDirection']
        : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality = map.containsKey('filterQuality')
        ? parseFilterQuality(map['filterQuality'])!
        : FilterQuality.low;

    int clickEvent =map['id'];

    var widget = Image.network(
      src,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null)) {
      return GestureDetector(
        onTap: () {
          listener.clickListener!.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  String get widgetName => "NetworkImage";

  @override
  Map<String, dynamic> export(Widget? widget, BuildContext? buildContext, int id) {
    var realWidget = widget as Image;
    late NetworkImage networkImage;
    if (realWidget.image is NetworkImage) {
      networkImage = realWidget.image as NetworkImage;
    } else if (realWidget.image is ResizeImage) {
      var t = realWidget.image as ResizeImage;
      networkImage = t.imageProvider as NetworkImage;
    }
    return <String, dynamic>{ "id":id,
      "type": widgetName,
      "src": networkImage.url,
      "semanticLabel": realWidget.semanticLabel,
      "excludeFromSemantics": realWidget.excludeFromSemantics,
      "width": realWidget.width,
      "height": realWidget.height,
      "color": realWidget.color != null
          ? realWidget.color!.value.toRadixString(16)
          : null,
      "colorBlendMode": realWidget.colorBlendMode != null
          ? exportBlendMode(realWidget.colorBlendMode)
          : null,
      "fit": realWidget.fit != null ? exportBoxFit(realWidget.fit) : null,
      "alignment": realWidget.alignment != null
          ? exportAlignment(realWidget.alignment as Alignment?)
          : null,
      "repeat": realWidget.repeat != null
          ? exportImageRepeat(realWidget.repeat)
          : null,
      "centerSlice": realWidget.centerSlice != null
          ? exportRect(realWidget.centerSlice!)
          : null,
      "matchTextDirection": realWidget.matchTextDirection,
      "gaplessPlayback": realWidget.gaplessPlayback,
      "filterQuality": realWidget.filterQuality != null
          ? exportFilterQuality(realWidget.filterQuality)
          : null
    };
  }

  @override
  Type get widgetType => NetworkImage;

  @override
  bool matchWidgetForExport(Widget? widget) {
    if (widget is Image) {
      if (widget.image is NetworkImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var t = widget.image as ResizeImage;
        return t.imageProvider is NetworkImage;
      }
    }
    return false;
  }
}
