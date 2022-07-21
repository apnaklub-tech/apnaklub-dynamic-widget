import 'dart:convert';

import 'package:dynamic_widget/dynamic_widget.dart';
import 'package:dynamic_widget/utils/event_listener.dart';
import 'package:flutter/widgets.dart';

class DynamicWidgetJsonExportor extends StatelessWidget {
  final Widget? child;

  final GlobalKey globalKey = GlobalKey();

  DynamicWidgetJsonExportor({
    this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: globalKey,
      child: child,
    );
  }

  String exportJsonString({String initID = ""}) {
    String rt = "failed to export";
    globalKey.currentContext!.visitChildElements((element) {
      rt = jsonEncode(DynamicWidgetBuilder.export(element.widget, null, initID));
    });
    return rt;
  }
}
